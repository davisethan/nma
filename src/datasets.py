from moabb.datasets import BNCI2014_001, BNCI2014_004, Cho2017, Lee2019_MI, PhysionetMI
from moabb.paradigms import LeftRightImagery

datasets = [BNCI2014_001(), BNCI2014_004(), Cho2017(), Lee2019_MI(), PhysionetMI()]
for dataset in datasets:
    paradigm = LeftRightImagery(resample=128)
    paradigm.get_data(
        dataset, cache_config=dict(use=True, save_array=True, overwrite_array=False)
    )
