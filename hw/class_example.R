library(haven)
CPS <- as_factor(read_dta(dir(pattern = "^cepr_.*dta$")))


defs <- sapply(CPS, FUN = attr, which = "label") 
vals <- sapply(CPS, FUN = attr, which = "levels")

CPS$