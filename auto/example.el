(TeX-add-style-hook "example"
 (lambda ()
    (LaTeX-add-bibliographies
     "refs")
    (TeX-run-style-hooks
     "latex2e"
     "biopaper10"
     "biopaper")))

