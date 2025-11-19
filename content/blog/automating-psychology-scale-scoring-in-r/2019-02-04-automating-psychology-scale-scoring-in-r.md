---
title: A workflow for automating scale scoring in R
author: Francisco Wilhelm
date: '2025-10-19'
format: hugo-md
slug: automating-scale-scoring-in-r
categories: []
tags:
  - R
  - statistics
  - psychometrics
summary: >-
  This post contains a workflow that vastly speeds up the process of scale
  scoring and computing psychometrics such as Cronbach's alpha.
---


Scoring scales is easily one of the most boring and repetitive tasks in the social sciences. In this post, we are going to learn how we can largely automate the process using R. The major advantages are both convenience, time-saving, and quick retrieval of the array of useful statistics for the items and scales in a dataset.

The R package **psych** features powerful functions for scoring survey scales. In this tutorial, we will use a wrapper for the `scoreItems` function to automate scale scoring.

## Data management: Naming variables in a consistent manner

A crucial inital step is to name the variables of a dataset consistently. This will later come in handy when we automate the scale construction, because we will construct an algorithm that looks for a certain pattern in the name of variables to identify them as items. Our goal is to create variable names that make clear that a specific item belongs to a specific scale.

-   bad example: "happy", "serene", "calm"
-   good example: "posaffect_1"","posaffect_2", "posaffect_3"

I recommend using the following pattern: "scalename_itemnumber".
For example

-   `agr_1` for the first item of an agreeableness scale, or
-   `neu_1` for the first item of a neuroticism scale.

Non-scale variables should not follow the same pattern in order to make it easy for the algorithm to distinguish items we want to score from variables we dont want to score. So, its best not to use the "characters_number" pattern for any non-scale variable. For example,
- `gender_1` should be renamed to `gender`

## Example dataset

This is the structure of our dataset:

``` r
head(df)
```

    # A tibble: 6 × 28
      agr_1 agr_2 agr_3 agr_4 agr_5 con_1 con_2 con_3 con_4 con_5 ext_1 ext_2 ext_3
      <int> <int> <int> <int> <int> <int> <int> <int> <int> <int> <int> <int> <int>
    1     2     4     3     4     4     2     3     3     4     4     3     3     3
    2     2     4     5     2     5     5     4     4     3     4     1     1     6
    3     5     4     5     4     4     4     5     4     2     5     2     4     4
    4     4     4     6     5     5     4     4     3     5     5     5     3     4
    5     2     3     3     4     5     4     4     5     3     2     2     2     5
    6     6     6     5     6     5     6     6     6     1     3     2     1     6
    # ℹ 15 more variables: ext_4 <int>, ext_5 <int>, neu_1 <int>, neu_2 <int>,
    #   neu_3 <int>, neu_4 <int>, neu_5 <int>, ope_1 <int>, ope_2 <int>,
    #   ope_3 <int>, ope_4 <int>, ope_5 <int>, gender <int>, education <int>,
    #   age <int>

We use a redacted `bfi` dataset from **psych**, which consists of 25 personality self-report items taken from the International Personality Item Pool (ipip.ori.org). We have measured each of the Big Five traits with five items.

Now, instead of calculating the scores of each of these five scales manually, we are going to automate the process[^1].

## Extracting all items

As you may have seen, the dataset also contains three demographic variables in addition to the scale items we want to use. Thus, we first have to select and extract all variables that are scale items from our dataset. This is where we need the unique naming structure of item-type variables, that is, variables which follow the structure **scalename_itemnumber**.

``` r
bigfiveitems <- dplyr::select(df, matches("_\\d$|_\\d.$"))
names(bigfiveitems)
```

     [1] "agr_1" "agr_2" "agr_3" "agr_4" "agr_5" "con_1" "con_2" "con_3" "con_4"
    [10] "con_5" "ext_1" "ext_2" "ext_3" "ext_4" "ext_5" "neu_1" "neu_2" "neu_3"
    [19] "neu_4" "neu_5" "ope_1" "ope_2" "ope_3" "ope_4" "ope_5"

What we make use of here is the `select` function from the `dplyr` package. It allows to select variables based upon regular expressions [^2]. Regular expressions allow us to describe patterns in strings, such as variable names here. The regular expression we use here tells the function to look for variable names that have an underdash ("\_") followed by a single digit number (e.g., 1).
Since all items follow this naming pattern, and, importantly, no non-item does, the functions quickly selects all the item variables.

Next, we automatically look for the scale names:

``` r
scalelist <- str_extract(names(bigfiveitems), "\\w+(?=_)")
scalelist <- unique(scalelist)
scalelist
```

    [1] "agr" "con" "ext" "neu" "ope"

As we can see, this next bit of code extracts the names of the scales, again using a regular expression. We could also supply the scalelist manually, e.g. `scalelist <- c("agr", "con", "ext", "neu", "ope")`

We now use the `scalelist` to tell `scoreItems` from the **psych** package to create scale scores for all of the scales listed in `scalelist`. This is handled via a function called `scoreItemsMulti` from the **franzpak** package[^3].

## Installing franzpak

If you haven't already installed franzpak, you can do so from GitHub:

``` r
# Install remotes if you don't have it
# install.packages("remotes")
remotes::install_github("franciscowilhelm/franzpak")
```

Then load the package:

``` r
library(franzpak)
```

``` r
bigfivescores <- scoreItemsMulti(scalelist, bigfiveitems)
```

The beauty of this function is that it takes the names of the scales and creates not only the scale scores, but also several useful statistics such as internal reliabilities, correlation matrices and others.

The scores themselves are available in the `scores` element of the object.

``` r
head(bigfivescores$scores)
```

      agr con ext neu ope
    1 4.0 2.8 3.8 2.8 3.0
    2 4.2 4.0 5.0 3.8 4.0
    3 3.8 4.0 4.2 3.6 4.8
    4 4.6 3.0 3.6 2.8 3.2
    5 4.0 4.4 4.8 3.2 3.6
    6 4.6 5.6 5.6 3.0 5.0

The reliabilities are given in the `alpha` element of the object.

``` r
bigfivescores$alpha
```

                agr       con      ext       neu       ope
    alpha 0.7031003 0.7273554 0.761868 0.8140709 0.6007539

**A word of caution:** If your scales contain reverse-worded items, `scoreItemsMulti` will try to automatically detect these[^4]. However, in such cases you should proceed with caution and consider checking manually whether it got it right. You can do this by inspecting the `$negative_index` element of your object. In the example case, some items were automatically reversed. You can also overwrite the automatic scoring by manually providing key instructions in the form of a named list, formatted like in the original scoreItems.

``` r
bigfivescores <- scoreItemsMulti(scalelist, bigfiveitems, manual_keys = list(con = c("con_1", "con_2", "con_3", "-con_4", "-con_5")))
```

    Some items were negatively correlated with total scale(s) and were (automatically) reversed. 
    Scales with reversed items: agr, ext, ope
    Please Check $negative_index for details.

## Alternative: Using scoreItemsMultiFast

For larger datasets or when you don't need reliability statistics, franzpak also provides `scoreItemsMultiFast`, which is a faster alternative that uses `psych::scoreFast()` under the hood. Unlike `scoreItemsMulti`, this function:

-   Does **not** calculate Cronbach's alpha or perform PCA
-   Does **not** automatically detect reverse-coded items
-   Is significantly faster for large datasets
-   Is suitable for cases with few observations where PCA or reliability estimation might fail

``` r
# Using scoreItemsMultiFast (no automatic reverse detection)
bigfivescores_fast <- scoreItemsMultiFast(scalelist, bigfiveitems,
                                          manual_keys = list(
                                            con = c("con_1", "con_2", "con_3", "-con_4", "-con_5"),
                                            ext = c("ext_1", "ext_2", "ext_3", "ext_4", "ext_5"),
                                            neu = c("neu_1", "neu_2", "neu_3", "neu_4", "neu_5"),
                                            ope = c("ope_1", "ope_2", "ope_3", "ope_4", "ope_5"),
                                            agr = c("-agr_1", "agr_2", "agr_3", "agr_4", "agr_5")
                                          ))
```

**Important:** When using `scoreItemsMultiFast` without `manual_keys`, the function will automatically find items based on naming conventions (items starting with the scale name followed by '.' or '\_') but will assume **no items are reverse-coded**. If you have reverse-coded items, you must specify them using the `manual_keys` parameter.

## Summary: The workflow

This workflow vastly speeds up the process of scale scoring and documentation of psychometrical attributes such as Cronbach's alpha.

Here is the recommended workflow in short:

1.  Install `franzpak` from GitHub using `remotes::install_github("franciscowilhelm/franzpak")`.
2.  Name variables such that all items follow the pattern 'scalename_itemnumber' (or 'scalename.itemnumber').
3.  Optional: Make sure that no other variables follow the pattern of 'characters_number'.
4.  Create a character vector holding all scale names either automatically or manually.
5.  Choose between `scoreItemsMulti` (includes reliability statistics, automatic reverse detection) or `scoreItemsMultiFast` (faster, no automatic reverse detection).
6.  Use your chosen function to create the scale scores and other attributes.
7.  If reverse-worded items are part of your scales:
    -   For `scoreItemsMulti`: Check the `$negative_index` element of your object to verify whether the function identified these correctly. If not, or to ensure consistency when data changes, manually specify scale keys with the `manual_keys` parameter.
    -   For `scoreItemsMultiFast`: You **must** manually specify all reverse-coded items using the `manual_keys` parameter, as this function does not perform automatic detection.

[^1]: with just five scales, this may seem like of over-engineering. Usually however, you will have a much larger dataset, where such an approach saves a lot of time.

[^2]: More info on regular expressions in R, especially the tidyverse packages: https://stringr.tidyverse.org/articles/regular-expressions.html

[^3]: The franzpak package is available on GitHub at https://github.com/franciscowilhelm/franzpak and can be installed using `remotes::install_github("franciscowilhelm/franzpak")`.

[^4]: The automatic detection of reverse-worded items is accomplished by running a PCA and reverse scoring those items that load negatively on the factor. This may not always work correctly.
