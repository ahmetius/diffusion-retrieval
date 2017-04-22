# Diffusion for image retrieval

This is a Matlab script for our paper:

> A. Iscen, G. Tolias, Y. Avrithis, T. Furon, O. Chum. "Efficient Diffusion on Region Manifolds: Recovering Small Objects with Compact CNN Representations", CVPR 2017

## Execution
Run the following script:
```
>> run_test
```

We provide the descriptors used in our paper and also the necessary ground-truth files for mAP evaluation.
In addition to that, we also make available the approximate kNN graph computed off-line with Dong et al. [10] for large-scale datasets. All the required files are stored in the link below and will be downloaded automatically when the script run_test.m is run. 

ftp://ftp.irisa.fr/local/texmex/corpus/diffusion/

Optional but recommended prerequisite:
Yael Library
http://yael.gforge.inria.fr/

All kNN computation will be done with Yael Library if it is found in the path. Even though this is not strictly required, we advise that Yael is installed for efficiency purposes.

Any questions or comments, should be addressed to ahmet.iscen@inria.fr


## License

This package is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program. If not, see http://www.gnu.org/licenses/.
