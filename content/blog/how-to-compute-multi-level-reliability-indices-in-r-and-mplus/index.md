---
title: How to compute multi-level reliability indices in R and Mplus
author: Francisco Wilhelm
date: '2019-05-11'
format: hugo-md
tags:
  - R
  - Mplus
  - statistics
  - psychometrics
slug: how-to-compute-multi-level-reliability-indices-in-r-and-mplus
---


## Update 2022

Since the time since I wrote this blog post, a package has been developed that calculates the multi-level reliability coefficient omega within R. See the function omegaSEM from [multilevelTools](http://joshuawiley.com/multilevelTools/reference/omegaSEM.html).

## Main post

Reliability estimation is one of the core tasks when working with psychological scales. However, reliability estimation with a multi-level data structure has only recently become a topic and its hard to find good materials for this. In this post, we are going to use several R packages and MPlus to compute the reliability of scales in a multi-level framework.

We use a multilevel confirmatory factor analysis (MCFA) to estimate the reliability of a psychological scale in a two-level framework. We are going to refer to level-1 as the within-level, and to level-2 as the between-level. The methods are described in Geldhof, Preacher, and Zyphur (2014) and Shrout and Lane (2012).

There are several reliability estimates available. The most common is Cronbach's Alpha. It can be extended to a multi-level framework. The estimate can be computed for both the within-level and the between-level. Omega is another index that is generally considered better than Alpha, but is less common.
When the multilevel data comes from an intensive longitudinal design, we also want to control for the (linear) time trend. This will be the case for our example.

## Tools

We use Mplus to do the statistical heavy-lifting here; possibly, the R package `lavaan` could also do this, but at the time of writing, `lavaan` still misses some multilevel functionality (such as handling missing level-1 data) that make Mplus the superior tool [^1]. We will utilize the R package `MPlusAutomation` to generate the syntax code, write the ".inp" files for Mplus and analyze the results.

``` r
library(MplusAutomation)
```

    Version:  1.1.1
    We work hard to write this free software. Please help us get credit by citing: 

    Hallquist, M. N. & Wiley, J. F. (2018). MplusAutomation: An R Package for Facilitating Large-Scale Latent Variable Analyses in Mplus. Structural Equation Modeling, 25, 621-638. doi: 10.1080/10705511.2017.1402334.

    -- see citation("MplusAutomation").

``` r
library(tidyverse)
```

    ── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
    ✔ dplyr     1.2.0     ✔ readr     2.1.6
    ✔ forcats   1.0.1     ✔ stringr   1.6.0
    ✔ ggplot2   4.0.2     ✔ tibble    3.3.1
    ✔ lubridate 1.9.4     ✔ tidyr     1.3.2
    ✔ purrr     1.2.1     

    ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
    ✖ tidyr::extract() masks MplusAutomation::extract()
    ✖ dplyr::filter()  masks stats::filter()
    ✖ dplyr::lag()     masks stats::lag()
    ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors

## Example Dataset

We use an example dataset provided by Bolger and Laurenceau (2013). You can get it from their website [here](http://www.intensivelongitudinal.com/ch7/ch7index.html), download and extract the ch7Mplus.zip file, the data is in the psychometrics.dat file. Because the dataset comes from an Mplus setting, we first have to modify it a little bit.

``` r
psychometrics <- as_tibble(readr::read_tsv("multilevel/psychometrics.dat"))
names(psychometrics) <- c("id", "time", "item1", "item2", "item3", "item4")
psychometrics <- psychometrics %>% mutate_all(~na_if(., -999))
```

``` r
head(psychometrics)
```

    # A tibble: 6 × 6
         id  time item1 item2 item3 item4
      <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
    1   301     2     2     3     3     2
    2   301     3     3     3     2     2
    3   301     4     4     3     3     3
    4   301     5     2     2     2     2
    5   301     6     2     2     1     2
    6   301     7     2     2     1     2

The data is long format, with multiple rows per person (`id` identifies the person) - one row for each `time` point, and four items belonging to the same scale measured at each time point.

Next we are going to source some code I created to help us prepare the Mplus Syntax for estimating the multilevel reliabilities.

``` r
source("https://raw.githubusercontent.com/franciscowilhelm/r-collection/master/modelstring.R")
```

Now we use `MplusAutomation` to create the Mplus object syntax. We are going to estimate Cronbach's $\alpha$ (alpha), $\omega$ (omega), and Maximal Reliability ( $H$ )[^2], each at the between- and the within-person level.

``` r
# define the names of the item variables we use
var_names <- c("item1", "item2", "item3", "item4")

# generate the MplusObject(s)
m_rel_omega <- mplusObject(
  TITLE = "MCFA RELIABILITY EXAMPLE",
  VARIABLE = "CLUSTER = id; \n WITHIN = time;",
  ANALYSIS = "TYPE = TWOLEVEL",
  MODEL = modelstring_omega_core(var_names, "time"),
  MODELCONSTRAINT = modelstring_omega_constraint(var_names),
  OUTPUT = "SAMPSTAT CINTERVAL;",
  usevariables = c(var_names, "id", "time"),
  rdata = psychometrics,
  autov = FALSE
)

m_rel_alpha <- mplusObject(
  TITLE = "MCFA RELIABILITY EXAMPLE",
  VARIABLE = "CLUSTER = id; \n WITHIN = time;",
  ANALYSIS = "TYPE = TWOLEVEL",
  MODEL = modelstring_alpha_core(var_names, "time"),
  MODELCONSTRAINT = modelstring_alpha_constraint(var_names),
  OUTPUT = "SAMPSTAT CINTERVAL;",
  usevariables = c(var_names, "id", "time"),
  rdata = psychometrics,
  autov = FALSE
)
```

Note that the "MODEL" and the MODELCONSTRAINT" sections of the syntax are generated using the functions we just sourced. The function takes the names of the item variables, and because we are using a longitudinal dataset, the name of the `time` variable. If you have data where level 1 is not longitudinal (e.g., persons in teams), you can just drop this argument.

Next, we write, run, and read the model.

``` r
m_rel_omega <- mplusModeler(m_rel_omega, modelout = "./multilevel/rel_omega.inp", run = FALSE)
m_rel_alpha <- mplusModeler(m_rel_alpha, modelout = "./multilevel/rel_alpha.inp", run = FALSE)

runModels(target = "multilevel")
```

``` r
m_rel_fit <- readModels(target = "multilevel")
```

Finally, we have to extract the reliability point estimates and then we are done!

``` r
knitr::kable(paramExtract(m_rel_fit[[1]]$parameters$unstandardized, "new"))
```

|     | paramHeader               | param    |   est |    se | est_se | pval | BetweenWithin |
|:---|:----------------------|:--------|-----:|-----:|------:|-----:|:------------|
| 29  | New.Additional.Parameters | COMP_V_W | 5.287 | 0.475 | 11.134 |    0 | Between       |
| 30  | New.Additional.Parameters | ALPHA_W  | 0.776 | 0.024 | 32.854 |    0 | Between       |
| 31  | New.Additional.Parameters | COMP_V_B | 6.416 | 1.223 |  5.246 |    0 | Between       |
| 32  | New.Additional.Parameters | ALPHA_B  | 0.884 | 0.038 | 23.396 |    0 | Between       |

``` r
knitr::kable(paramExtract(m_rel_fit[[2]]$parameters$unstandardized, "new"))
```

|     | paramHeader               | param   |   est |    se | est_se | pval | BetweenWithin |
|:---|:----------------------|:-------|------:|------:|------:|-----:|:------------|
| 27  | New.Additional.Parameters | NUM_W   | 4.116 | 0.463 |  8.883 |    0 | Between       |
| 28  | New.Additional.Parameters | DENOM_W | 5.289 | 0.475 | 11.127 |    0 | Between       |
| 29  | New.Additional.Parameters | OMEGA_W | 0.778 | 0.023 | 34.119 |    0 | Between       |
| 30  | New.Additional.Parameters | H_W     | 0.785 | 0.021 | 37.388 |    0 | Between       |
| 31  | New.Additional.Parameters | NUM_B   | 5.689 | 1.264 |  4.501 |    0 | Between       |
| 32  | New.Additional.Parameters | DENOM_B | 6.411 | 1.223 |  5.243 |    0 | Between       |
| 33  | New.Additional.Parameters | OMEGA_B | 0.887 | 0.036 | 24.482 |    0 | Between       |
| 34  | New.Additional.Parameters | H_B     | 0.931 | 0.043 | 21.576 |    0 | Between       |

In the code above we use the `MplusAutomation::paramExtract` function to get all the parameters created through Mplus model constraints by using the `"new"` argument. Note that the Alpha model gives us the Alpha at between-level (ALPHA_B) and at the within-level (ALPHA_W), whereas the Omega model gives us Omega and H at the between-level (OMEGA_B & H_B) and at the within-level (OMEGA_W & H_W). Please do not let your self get confused by the "BetweenWithin" column - manually created parameters in Mplus are always given as Between, even when they are not. The other parameters (NUM & DENOM) are used for the calculations and can be be ignored.

As we can see, the reliabilities for our four item scale are quite decent, even at the within-level with values above .70. This means that not only does the scale capture between-person differences reliably, but also within-person changes from the person's mean level.

## Sources

Geldhof, G. J., Preacher, K. J., & Zyphur, M. J. (2014). Reliability estimation in a multilevel confirmatory factor analysis framework. *Psychological Methods*, 19(1), 72--91. https://doi.org/10.1037/a0032138

Shrout, P. E., & Lane, S. P. (2012). Psychometrics. In M. R. Mehl & T. S. Conner (Eds.), *Handbook of research methods for studying daily life *(pp. 302-320). New York, NY, US: The Guilford Press.

[^1]: If you do not have access to Mplus, you may want to use an ANOVA framework instead of the MCFA framework we use here. For more, see the excellent book by Bolger and Laurenceau (2013) and its [accompanying website](http://www.intensivelongitudinal.com/index.html) which has the R code for it. Thanks to [Jennifer Inauen](http://www.gpv.psy.unibe.ch/ueber_uns/personen/jinauen/index_ger.html) for pointing out this book to me.

[^2]: For more information see Geldhof et al. (2014).
