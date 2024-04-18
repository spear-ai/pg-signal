INSERT INTO public.audio_signal (id, name, description)
VALUES (
    '651b8e30-6e90-415f-ab59-ff182f5ba7cc',
    'NOAAS Reuben Lasker',
    'Audio signal from the NOAAS Reuben Lasker in the DCLDE dataset.'
);

INSERT INTO public.audio_channel (id, name, description, number, sample_rate)
VALUES (
    'c0143fd6-8e9f-438e-9ab7-42a8f42f89bc',
    'Inline array, Hydrophone 1',
    'First hydrophone in the first array cluster.',
    1,
    '00:00:00.000002'::interval
);

INSERT INTO public.audio_channel (id, name, description, number, sample_rate)
VALUES (
    '8f869547-c4e1-4f3f-bc49-a0c9ff033878',
    'Inline array, Hydrophone 2',
    'Second hydrophone in the first array cluster.',
    2,
    '00:00:00.000002'::interval
);

INSERT INTO public.audio_channel (id, name, description, number, sample_rate)
VALUES (
    'b32120a2-f4f0-455a-b8b0-c6bd11e397ad',
    'Inline array, Hydrophone 3',
    'Third hydrophone in the first array cluster.',
    3,
    '00:00:00.000002'::interval
);

INSERT INTO public.audio_channel (id, name, description, number, sample_rate)
VALUES (
    'be154b1c-eb1f-4b11-a500-c36ebfa49993',
    'End array, Hydrophone 1',
    'First hydrophone in the second array cluster.',
    4,
    '00:00:00.000002'::interval
);

INSERT INTO public.audio_channel (id, name, description, number, sample_rate)
VALUES (
    'ce42f9a5-9135-4d2e-8e58-a43ec19430d5',
    'End array, Hydrophone 2',
    'Second hydrophone in the second array cluster.',
    5,
    '00:00:00.000002'::interval
);

INSERT INTO public.audio_channel (id, name, description, number, sample_rate)
VALUES (
    'e965f1f7-3548-4a67-b60f-2b32294005ec',
    'End array, Hydrophone 3',
    'Third hydrophone in the second array cluster.',
    6,
    '00:00:00.000002'::interval
);

INSERT INTO public.audio_signal_channel (id, signal_id, channel_id)
VALUES (
    '3834c3a4-dd65-4c22-97b3-e874fa53164a',
    '651b8e30-6e90-415f-ab59-ff182f5ba7cc',
    'c0143fd6-8e9f-438e-9ab7-42a8f42f89bc'
), (
    '311fe0c6-210d-4931-bfab-b6bbe023370f',
    '651b8e30-6e90-415f-ab59-ff182f5ba7cc',
    '8f869547-c4e1-4f3f-bc49-a0c9ff033878'
), (
    '579c2580-cd49-40fe-afde-ebc2f55a5afe',
    '651b8e30-6e90-415f-ab59-ff182f5ba7cc',
    'b32120a2-f4f0-455a-b8b0-c6bd11e397ad'
), (
    '0aca35c0-ab92-459a-8fad-d363a2f6c7b7',
    '651b8e30-6e90-415f-ab59-ff182f5ba7cc',
    'be154b1c-eb1f-4b11-a500-c36ebfa49993'
), (
    '129d6d11-7ed1-4c83-a497-e4c2ff95d9b0',
    '651b8e30-6e90-415f-ab59-ff182f5ba7cc',
    'ce42f9a5-9135-4d2e-8e58-a43ec19430d5'
), (
    '080d96e2-7fa1-4129-90e8-332433284ec0',
    '651b8e30-6e90-415f-ab59-ff182f5ba7cc',
    'e965f1f7-3548-4a67-b60f-2b32294005ec'
);

COPY public.audio_sample (amplitude, datetime, signal_channel_id)
FROM '/var/lib/postgresql/files/audio_sample_0_0_channel_1.csv' DELIMITER ',' CSV HEADER; -- noqa: PRS

COPY public.audio_sample (amplitude, datetime, signal_channel_id)
FROM '/var/lib/postgresql/files/audio_sample_0_1_channel_1.csv' DELIMITER ',' CSV HEADER; -- noqa: PRS

COPY public.audio_sample (amplitude, datetime, signal_channel_id)
FROM '/var/lib/postgresql/files/audio_sample_0_2_channel_1.csv' DELIMITER ',' CSV HEADER; -- noqa: PRS

-- COPY public.audio_sample (amplitude, datetime, signal_channel_id)
-- FROM '/var/lib/postgresql/files/audio_sample_1_0_channel_1.csv' DELIMITER ',' CSV HEADER; -- noqa: PRS

-- COPY public.audio_sample (amplitude, datetime, signal_channel_id)
-- FROM '/var/lib/postgresql/files/audio_sample_1_1_channel_1.csv' DELIMITER ',' CSV HEADER; -- noqa: PRS

-- COPY public.audio_sample (amplitude, datetime, signal_channel_id)
-- FROM '/var/lib/postgresql/files/audio_sample_1_2_channel_1.csv' DELIMITER ',' CSV HEADER; -- noqa: PRS

-- COPY public.audio_sample (amplitude, datetime, signal_channel_id)
-- FROM '/var/lib/postgresql/files/audio_sample_2_0_channel_1.csv' DELIMITER ',' CSV HEADER; -- noqa: PRS

-- COPY public.audio_sample (amplitude, datetime, signal_channel_id)
-- FROM '/var/lib/postgresql/files/audio_sample_2_1_channel_1.csv' DELIMITER ',' CSV HEADER; -- noqa: PRS

-- COPY public.audio_sample (amplitude, datetime, signal_channel_id)
-- FROM '/var/lib/postgresql/files/audio_sample_2_2_channel_1.csv' DELIMITER ',' CSV HEADER; -- noqa: PRS

-- COPY public.audio_sample (amplitude, datetime, signal_channel_id)
-- FROM '/var/lib/postgresql/files/audio_sample_3_0_channel_1.csv' DELIMITER ',' CSV HEADER; -- noqa: PRS

-- COPY public.audio_sample (amplitude, datetime, signal_channel_id)
-- FROM '/var/lib/postgresql/files/audio_sample_3_1_channel_1.csv' DELIMITER ',' CSV HEADER; -- noqa: PRS

-- COPY public.audio_sample (amplitude, datetime, signal_channel_id)
-- FROM '/var/lib/postgresql/files/audio_sample_3_2_channel_1.csv' DELIMITER ',' CSV HEADER; -- noqa: PRS

-- COPY public.audio_sample (amplitude, datetime, signal_channel_id)
-- FROM '/var/lib/postgresql/files/audio_sample_4_0_channel_1.csv' DELIMITER ',' CSV HEADER; -- noqa: PRS

-- COPY public.audio_sample (amplitude, datetime, signal_channel_id)
-- FROM '/var/lib/postgresql/files/audio_sample_4_1_channel_1.csv' DELIMITER ',' CSV HEADER; -- noqa: PRS

-- COPY public.audio_sample (amplitude, datetime, signal_channel_id)
-- FROM '/var/lib/postgresql/files/audio_sample_4_2_channel_1.csv' DELIMITER ',' CSV HEADER; -- noqa: PRS

-- COPY public.columnar_audio_sample (amplitude, datetime, signal_channel_id)
-- FROM '/var/lib/postgresql/files/audio_sample_0_0_channel_1.csv' DELIMITER ',' CSV HEADER; -- noqa: PRS

-- COPY public.columnar_audio_sample (amplitude, datetime, signal_channel_id)
-- FROM '/var/lib/postgresql/files/audio_sample_0_1_channel_1.csv' DELIMITER ',' CSV HEADER; -- noqa: PRS

-- COPY public.columnar_audio_sample (amplitude, datetime, signal_channel_id)
-- FROM '/var/lib/postgresql/files/audio_sample_0_2_channel_1.csv' DELIMITER ',' CSV HEADER; -- noqa: PRS

-- COPY public.columnar_audio_sample (amplitude, datetime, signal_channel_id)
-- FROM '/var/lib/postgresql/files/audio_sample_1_0_channel_1.csv' DELIMITER ',' CSV HEADER; -- noqa: PRS

-- COPY public.columnar_audio_sample (amplitude, datetime, signal_channel_id)
-- FROM '/var/lib/postgresql/files/audio_sample_1_1_channel_1.csv' DELIMITER ',' CSV HEADER; -- noqa: PRS

-- COPY public.columnar_audio_sample (amplitude, datetime, signal_channel_id)
-- FROM '/var/lib/postgresql/files/audio_sample_1_2_channel_1.csv' DELIMITER ',' CSV HEADER; -- noqa: PRS

-- COPY public.columnar_audio_sample (amplitude, datetime, signal_channel_id)
-- FROM '/var/lib/postgresql/files/audio_sample_2_0_channel_1.csv' DELIMITER ',' CSV HEADER; -- noqa: PRS

-- COPY public.columnar_audio_sample (amplitude, datetime, signal_channel_id)
-- FROM '/var/lib/postgresql/files/audio_sample_2_1_channel_1.csv' DELIMITER ',' CSV HEADER; -- noqa: PRS

-- COPY public.columnar_audio_sample (amplitude, datetime, signal_channel_id)
-- FROM '/var/lib/postgresql/files/audio_sample_2_2_channel_1.csv' DELIMITER ',' CSV HEADER; -- noqa: PRS

-- COPY public.columnar_audio_sample (amplitude, datetime, signal_channel_id)
-- FROM '/var/lib/postgresql/files/audio_sample_3_0_channel_1.csv' DELIMITER ',' CSV HEADER; -- noqa: PRS

-- COPY public.columnar_audio_sample (amplitude, datetime, signal_channel_id)
-- FROM '/var/lib/postgresql/files/audio_sample_3_1_channel_1.csv' DELIMITER ',' CSV HEADER; -- noqa: PRS

-- COPY public.columnar_audio_sample (amplitude, datetime, signal_channel_id)
-- FROM '/var/lib/postgresql/files/audio_sample_3_2_channel_1.csv' DELIMITER ',' CSV HEADER; -- noqa: PRS

-- COPY public.columnar_audio_sample (amplitude, datetime, signal_channel_id)
-- FROM '/var/lib/postgresql/files/audio_sample_4_0_channel_1.csv' DELIMITER ',' CSV HEADER; -- noqa: PRS

-- COPY public.columnar_audio_sample (amplitude, datetime, signal_channel_id)
-- FROM '/var/lib/postgresql/files/audio_sample_4_1_channel_1.csv' DELIMITER ',' CSV HEADER; -- noqa: PRS

-- COPY public.columnar_audio_sample (amplitude, datetime, signal_channel_id)
-- FROM '/var/lib/postgresql/files/audio_sample_4_2_channel_1.csv' DELIMITER ',' CSV HEADER; -- noqa: PRS
