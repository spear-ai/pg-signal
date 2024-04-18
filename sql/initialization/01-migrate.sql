CREATE EXTENSION IF NOT EXISTS citext WITH SCHEMA public;
CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;

CREATE OR REPLACE FUNCTION public.trigger__update_datetime()
RETURNS trigger AS $$
BEGIN
  NEW.created_datetime = (CASE WHEN TG_OP = 'INSERT'
    THEN NOW()
    ELSE OLD.created_datetime
  END);

  NEW.modified_datetime = (CASE WHEN TG_OP = 'UPDATE' AND OLD.modified_datetime >= NOW()
    THEN OLD.modified_datetime + interval '1 millisecond'
    ELSE NOW()
  END);

  return NEW;
END;
$$ LANGUAGE plpgsql VOLATILE SET search_path TO pg_catalog, pg_temp, public;

COMMENT ON FUNCTION public.trigger__update_datetime() IS
E'This trigger should be called on all tables with `created_datetime` and `modified_datetime` columns. It ensures that the datetime columns cannot be manipulated and that the `updated_datetime` increases monotonically.'; -- noqa: LT05

DROP TABLE IF EXISTS public.audio_signal CASCADE;

CREATE UNLOGGED TABLE public.audio_signal (
    id uuid PRIMARY KEY DEFAULT GEN_RANDOM_UUID(),
    created_datetime timestamptz,
    modified_datetime timestamptz,
    name citext,
    description text
) USING heap;

CREATE OR REPLACE TRIGGER _100_modify_datetime BEFORE INSERT OR UPDATE
ON public.audio_signal FOR EACH ROW
EXECUTE PROCEDURE public.trigger__update_datetime();

COMMENT ON TABLE public.audio_signal IS
E'An audio stream sampled at regular intervals from one or more channels.';

COMMENT ON COLUMN public.audio_signal.id IS
E'The unique identifier of the audio signal.';

COMMENT ON COLUMN public.audio_signal.created_datetime IS
E'The date and time the audio signal was first created.';

COMMENT ON COLUMN public.audio_signal.modified_datetime IS
E'The date and time the audio signal was last modified.';

COMMENT ON COLUMN public.audio_signal.name IS
E'The name of the audio signal.';

COMMENT ON COLUMN public.audio_signal.description IS
E'The description of the audio signal.';

DROP TABLE IF EXISTS public.audio_channel CASCADE;

CREATE UNLOGGED TABLE public.audio_channel (
    id uuid PRIMARY KEY DEFAULT GEN_RANDOM_UUID(),
    created_datetime timestamptz,
    modified_datetime timestamptz,
    name citext,
    description text,
    number int,
    sample_rate interval
) USING heap;

CREATE OR REPLACE TRIGGER _100_modify_datetime BEFORE INSERT OR UPDATE
ON public.audio_channel FOR EACH ROW
EXECUTE PROCEDURE public.trigger__update_datetime();

COMMENT ON TABLE public.audio_channel IS
E'A subcomponent of an audio stream.';

COMMENT ON COLUMN public.audio_channel.id IS
E'The unique identifier of the audio channel.';

COMMENT ON COLUMN public.audio_channel.created_datetime IS
E'The date and time the audio channel was first created.';

COMMENT ON COLUMN public.audio_channel.modified_datetime IS
E'The date and time the audio channel was last modified.';

COMMENT ON COLUMN public.audio_channel.name IS
E'The name of the audio channel.';

COMMENT ON COLUMN public.audio_channel.description IS
E'The description of the audio channel.';

COMMENT ON COLUMN public.audio_channel.number IS
E'The number of the audio channel.';

COMMENT ON COLUMN public.audio_channel.sample_rate IS
E'The sample frequency of the audio channel source.';

DROP TABLE IF EXISTS public.audio_signal_channel CASCADE;

CREATE UNLOGGED TABLE public.audio_signal_channel (
    id uuid PRIMARY KEY DEFAULT GEN_RANDOM_UUID(),
    created_datetime timestamptz,
    modified_datetime timestamptz,
    signal_id uuid REFERENCES public.audio_signal (id),
    channel_id uuid REFERENCES public.audio_channel (id)
) USING heap;

CREATE OR REPLACE TRIGGER _100_modify_datetime BEFORE INSERT OR UPDATE
ON public.audio_signal_channel FOR EACH ROW
EXECUTE PROCEDURE public.trigger__update_datetime();

COMMENT ON TABLE public.audio_signal_channel IS
E'An audio signal channel.';

COMMENT ON COLUMN public.audio_signal_channel.id IS
E'The unique identifier of the audio signal channel.';

COMMENT ON COLUMN public.audio_signal_channel.created_datetime IS
E'The date and time the audio signal channel was first created.';

COMMENT ON COLUMN public.audio_signal_channel.modified_datetime IS
E'The date and time the audio signal channel was last modified.';

COMMENT ON COLUMN public.audio_signal_channel.signal_id IS
E'The identifier of the audio signal.';

COMMENT ON COLUMN public.audio_signal_channel.channel_id IS
E'The identifier of the audio channel.';

DROP TABLE IF EXISTS public.audio_sample CASCADE;

CREATE UNLOGGED TABLE public.audio_sample (
    id uuid PRIMARY KEY DEFAULT GEN_RANDOM_UUID(),
    created_datetime timestamptz,
    modified_datetime timestamptz,
    signal_channel_id uuid REFERENCES public.audio_signal_channel (id),
    datetime timestamptz,
    amplitude real
) USING heap;

CREATE OR REPLACE TRIGGER _100_modify_datetime BEFORE INSERT OR UPDATE
ON public.audio_sample FOR EACH ROW
EXECUTE PROCEDURE public.trigger__update_datetime();

CREATE INDEX ON public.audio_sample (datetime);
CREATE INDEX ON public.audio_sample (signal_channel_id);

COMMENT ON TABLE public.audio_sample IS
E'A sample from a continuous audio signal.';

COMMENT ON COLUMN public.audio_sample.id IS
E'The unique identifier of the audio sample.';

COMMENT ON COLUMN public.audio_sample.created_datetime IS
E'The date and time the audio sample was first created.';

COMMENT ON COLUMN public.audio_sample.modified_datetime IS
E'The date and time the audio sample was last modified.';

COMMENT ON COLUMN public.audio_sample.datetime IS
E'The date and time of the audio sample.';

COMMENT ON COLUMN public.audio_sample.amplitude IS
E'The amplitude of the audio sample.';

COMMENT ON COLUMN public.audio_sample.signal_channel_id IS
E'The identifier of the audio sample’s channel signal.';

CREATE TABLE public.columnar_audio_sample (
    id uuid PRIMARY KEY DEFAULT GEN_RANDOM_UUID(),
    created_datetime timestamptz,
    modified_datetime timestamptz,
    signal_channel_id uuid,
    datetime timestamptz,
    amplitude real
) USING columnar;

CREATE OR REPLACE TRIGGER _100_modify_datetime BEFORE INSERT OR UPDATE
ON public.columnar_audio_sample FOR EACH ROW
EXECUTE PROCEDURE public.trigger__update_datetime();

CREATE INDEX ON public.columnar_audio_sample (datetime);

COMMENT ON TABLE public.columnar_audio_sample IS
E'A sample from a continuous audio signal stored in a column-oriented table.';

COMMENT ON COLUMN public.columnar_audio_sample.id IS
E'The unique identifier of the audio sample.';

COMMENT ON COLUMN public.columnar_audio_sample.created_datetime IS
E'The date and time the audio sample was first created.';

COMMENT ON COLUMN public.columnar_audio_sample.modified_datetime IS
E'The date and time the audio sample was last modified.';

COMMENT ON COLUMN public.audio_sample.datetime IS
E'The date and time of the audio sample.';

COMMENT ON COLUMN public.columnar_audio_sample.amplitude IS
E'The amplitude of the audio sample.';

COMMENT ON COLUMN public.columnar_audio_sample.signal_channel_id IS
E'The identifier of the audio sample’s channel signal.';
