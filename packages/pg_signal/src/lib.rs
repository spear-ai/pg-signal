//! A signal processing extension for Postgres.

use pgrx::pg_module_magic;
use pgrx::prelude::*;
use rustfft::{num_complex::Complex, FftPlanner};

pg_module_magic!();

extension_sql!(
    "\
CREATE TYPE signal.complex_float4 AS (
    real float4,
    imaginary float4
);

CREATE TYPE signal.complex_float8 AS (
    real float8,
    imaginary float8
);
    ",
    name = "create_composites",
    bootstrap
);

/// Convert from a Postgres `complex_float4` tuple to a Rust `Complex<f32>`.
fn complex_to_tuple_32(complex: &Complex<f32>) -> PgHeapTuple<'static, AllocatedByRust> {
    #![allow(clippy::single_call_fn)]
    let mut tuple = PgHeapTuple::new_composite_type("signal.complex_float4").unwrap();
    tuple.set_by_name("real", complex.re).unwrap();
    tuple.set_by_name("imaginary", complex.im).unwrap();
    return tuple;
}

/// Convert from a Postgres `complex_float8` tuple to a Rust `Complex<f64>`.
fn complex_to_tuple_64(complex: &Complex<f64>) -> PgHeapTuple<'static, AllocatedByRust> {
    #![allow(clippy::single_call_fn)]
    let mut tuple = PgHeapTuple::new_composite_type("signal.complex_float8").unwrap();
    tuple.set_by_name("real", complex.re).unwrap();
    tuple.set_by_name("imaginary", complex.im).unwrap();
    return tuple;
}

/// Convert from a Rust `Complex<f32>` to a Postgres `complex_float4` tuple.
fn tuple_to_complex_32(tuple: &PgHeapTuple<'static, AllocatedByRust>) -> Complex<f32> {
    #![allow(clippy::single_call_fn)]
    let real: f32 = tuple.get_by_name("real").unwrap().unwrap_or_default();
    let imaginary: f32 = tuple.get_by_name("imaginary").unwrap().unwrap_or_default();
    return Complex::new(real, imaginary);
}

/// Convert from a Rust `Complex<f64>` to a Postgres `complex_float8` tuple.
fn tuple_to_complex_64(tuple: &PgHeapTuple<'static, AllocatedByRust>) -> Complex<f64> {
    #![allow(clippy::single_call_fn)]
    let real: f64 = tuple.get_by_name("real").unwrap().unwrap_or_default();
    let imaginary: f64 = tuple.get_by_name("imaginary").unwrap().unwrap_or_default();
    return Complex::new(real, imaginary);
}

#[pg_extern]
fn fft_float4(
    input: Vec<pgrx::composite_type!("signal.complex_float4")>,
) -> Vec<pgrx::composite_type!("signal.complex_float4")> {
    let mut buffer: Vec<Complex<f32>> = input.iter().map(tuple_to_complex_32).collect();
    let mut planner = FftPlanner::<f32>::new();
    let fft = planner.plan_fft_forward(buffer.len());
    fft.process(&mut buffer);
    return buffer.iter().map(complex_to_tuple_32).collect();
}

#[pg_extern]
fn fft_float8(
    input: Vec<pgrx::composite_type!("signal.complex_float8")>,
) -> Vec<pgrx::composite_type!("signal.complex_float8")> {
    let mut buffer: Vec<Complex<f64>> = input.iter().map(tuple_to_complex_64).collect();
    let mut planner = FftPlanner::<f64>::new();
    let fft = planner.plan_fft_forward(input.len());
    fft.process(&mut buffer);
    return buffer.iter().map(complex_to_tuple_64).collect();
}

#[cfg(test)]
pub mod pg_test {
    pub fn setup(_options: Vec<&str>) {
        // perform one-off initialization when the pg_test framework starts
    }

    pub fn postgresql_conf_options() -> Vec<&'static str> {
        // return any postgresql.conf settings that are required for your tests
        vec![]
    }
}

#[cfg(any(test, feature = "pg_test"))]
#[pg_schema]
mod tests {
    use pgrx::prelude::*;

    #[pg_test]
    fn test_fft_float4() {
        let result = Spi::get_one::<f32>(
            "SELECT spectrum.real FROM UNNEST(signal.fft_float4(ARRAY[(1.0, 0.0), (2.0, 0.0), (3.0, 0.0), (4.0, 0.0)]::signal.complex_float4[])) AS spectrum;",
        );

        assert_eq!(result, Ok(Some(10.0)));
    }

    #[pg_test]
    fn test_fft_float8() {
        let result = Spi::get_one::<f32>(
            "SELECT spectrum.real FROM UNNEST(signal.fft_float8(ARRAY[(1.0, 0.0), (2.0, 0.0), (3.0, 0.0), (4.0, 0.0)]::signal.complex_float8[])) AS spectrum;",
        );

        assert_eq!(result, Ok(Some(10.0)));
    }
}
