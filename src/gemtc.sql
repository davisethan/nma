WITH scores AS (
    SELECT
        dataset,
        pipeline,
        subject,
        AVG(score) AS mean_session_score
    FROM results
    GROUP BY dataset, pipeline, subject
)

SELECT
    dataset AS study,
    REPLACE(pipeline, '+', '_') AS treatment,
    AVG(mean_session_score) AS mean,
    STDDEV_SAMP(mean_session_score) AS "std.dev",
    COUNT(*) AS "sampleSize"
FROM scores
GROUP BY dataset, pipeline
ORDER BY study, treatment
