# https://setuptools.pypa.io/en/latest/userguide/declarative_config.html
import os
from setuptools import setup, find_packages


REQUIRED_PACKAGES = open("requirements.txt").readlines()

DEV_PACKAGES = []
if os.path.exists("requirements.dev.txt"):
    DEV_PACKAGES = open("requirements.dev.txt").readlines()

README = ""
if os.path.exists("README.md"):
    README = open("README.md").read()

setup(
    name="python-pkg",
    version="0.0.1",
    long_description=README,
    long_description_content_type="text/markdown",
    author="AcNaWeb",
    author_email="ac@marketmining.com.br",
    url="https://github.com/acnaweb/python",
    install_requires=REQUIRED_PACKAGES,
    extras_require={"interactive": DEV_PACKAGES},
    packages=find_packages(include=["src", "src.*"]),
    platforms="any",
)
