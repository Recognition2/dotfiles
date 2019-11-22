# Run a bunch of imports
try:
    import os
    import sys
    import itertools as it
    import more_itertools as mit
    import functools as ft
    import time

    import numpy as np
    import scipy
    import scipy.stats
    import scipy.integrate
    import matplotlib.pyplot as plt

except ImportError as e:
    print("Import failed: ", e)

# Change how the interpreter looks. Defaults: ps1='>>>', ps2='...'
sys.ps1 = 'py> '
sys.ps2 = 'py. '


# Some aliases that are often needed.
lf = lambda f, l: np.array(list(filter(f, l)))
lm = lambda f, l: np.array(list(map(f, l)))


