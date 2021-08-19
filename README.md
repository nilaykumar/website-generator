# [nilaykumar.github.io](https://nilaykumar.github.io/)

This project is my static site generator.

Most of my writing is done in LaTeX. The code here converts my LaTeX code to
HTML using `pandoc` (see `transpile.sh` for the details). After conversion (and
extraction of relevant metadata), these HTML fragments are put put together
using Metalsmith and `nunjucks` (in `build.js`) and then deployed to GitHub
pages (in `deploy.sh`).

The output of the static site generator can be found [here](https://github.com/nilaykumar/nilaykumar.github.io).
