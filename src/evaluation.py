from moabb.datasets import BNCI2014_001, BNCI2014_004, Cho2017, Lee2019_MI, PhysionetMI
from moabb.evaluations import CrossSubjectEvaluation
from moabb.paradigms import LeftRightImagery
from pyriemann.classification import MDM
from pyriemann.estimation import Covariances
from pyriemann.spatialfilters import CSP
from pyriemann.tangentspace import TangentSpace
from sklearn.discriminant_analysis import LinearDiscriminantAnalysis as LDA
from sklearn.pipeline import make_pipeline
from sklearn.svm import SVC

datasets = [BNCI2014_001(), BNCI2014_004(), Cho2017(), Lee2019_MI(), PhysionetMI()]
paradigm = LeftRightImagery(resample=128)
evaluation = CrossSubjectEvaluation(
    paradigm=paradigm,
    datasets=datasets,
    overwrite=False,
    n_splits=min(dataset.metadata.participants.n_subjects for dataset in datasets),
    cache_config=dict(
        use=True,
        save_array=True,
        overwrite_array=False,
    ),
)

pipelines = {
    "CSP+LDA": make_pipeline(
        Covariances(estimator="oas"),
        CSP(nfilter=6),
        LDA(solver="svd"),
    ),
    "TS+SVM": make_pipeline(
        Covariances(estimator="oas"),
        TangentSpace(metric="riemann"),
        SVC(kernel="linear"),
    ),
    "MDM": make_pipeline(Covariances(estimator="oas"), MDM(metric="riemann")),
}

results = evaluation.process(pipelines)
