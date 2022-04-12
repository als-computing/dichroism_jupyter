#!/usr/bin/env python

"""A setuptools-based setup module for alshub_api
"""

# Always prefer setuptools over distutils
from setuptools import setup, find_packages
# To use a consistent encoding
from codecs import open
from os import path

# Non-qualified import of `versioneer`; local file is intended
import versioneer

here = path.abspath(path.dirname(__file__))

# Get the long description from the README file
with open(path.join(here, 'README.md'), encoding='utf-8') as f:
    long_description = f.read()

setup(
    name='dichroism_jupyter',

    version=versioneer.get_version(), 
    cmdclass=versioneer.get_cmdclass(), 

    description='Conda environments for processing ALS Dichroism data', 
    long_description=long_description, 
    long_description_content_type='text/markdown',

    url='https://github.com/als-computing/dichroism_jupyter', 

    author='Padraic Shafer', 
    author_email='pshafer@lbl.gov', 

    classifiers=[ 
        # How mature is this project? Common values are
        #   3 - Alpha
        #   4 - Beta
        #   5 - Production/Stable
        'Development Status :: 5 - Production/Stable',

        # Indicate who your project is intended for
        'Intended Audience :: Developers', 
        'Intended Audience :: Science/Research',
        'Topic :: Scientific/Engineering :: Information Analysis', 
        'Topic :: Utilities', 

        # Pick your license as you wish
        # 'License :: OSI Approved :: BSD License :: BSD-3-Clause-LBNL',
        'License :: OSI Approved :: BSD License', # 'BSD-3-Clause-LBNL'

        # Specify the Python versions you support here. In particular, ensure
        # that you indicate whether you support Python 2, Python 3 or both.
        'Programming Language :: Python :: 3.8',
        'Programming Language :: Python :: 3.9',
        'Programming Language :: Python :: 3.10',

        'Operating System :: OS Independent',
        'Environment :: Console',
    ],

    keywords='ALS Dichroism DXR Conda Jupyter Python Docker', 

    packages=find_packages(exclude=['contrib', 'docs', 'tests']), 

    install_requires=[
        'PkgScript', 
        ], 

    extras_require={  # Optional
        # 'dev': ['check-manifest'],
        # 'test': ['coverage'],
    },

    include_package_data=True,

    entry_points={  # Optional
        'console_scripts': [
            # TBD,
        ],
    },
)