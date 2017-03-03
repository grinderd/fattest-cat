
<!-- README.md is generated from README.Rmd. Please edit that file -->
> Some cats are born fat, some achieve fatness, others have fatness thrust upon them.

An [\#rstats](https://twitter.com/hashtag/rstats) tribute script, in honor of the very charming [lexiross/fattest-cat](https://github.com/lexiross/fattest-cat), a script to find the fattest [cat currently up for adoption at SF SPCA](https://www.sfspca.org/adoptions/cats). Why should JavaScript have all the fun?

Incidentally, this makes a pretty good demo of using the [tidyverse](https://blog.rstudio.org/2016/09/15/tidyverse-1-0-0/) to work in a style I call [Data Rectangling](https://speakerdeck.com/jennybc/data-rectangling).

Install and call
----------------

From a shell

    wget https://raw.githubusercontent.com/jennybc/fattest-cat/master/fattest-cat.R
    chmod +x fattest-cat.R
    ./fattest-cat.R

From R

``` r
url <- "https://raw.githubusercontent.com/jennybc/fattest-cat/master/fattest-cat.R"
rfile <- basename(url)
download.file(url, rfile)
source(rfile)
```

Demo
----

``` sh
./fattest-cat.R
#> Accessing San Francisco SPCA (Cat Department)...
#> Reading page 0 of cats
#>   36 cat listings found
#> Reading page 1 of cats
#>   32 cat listings found
#> Reading page 2 of cats
#>   no more cat listings, over and out
#> Cat information system accessed.
#>   30 unique cats found.
#> Beginning weighing process...
#>              name      weight    sex       id
#> 1        Koshinka 8lbs. 13oz. Female 34754223
#> 2             Pia      11lbs. Female  5753532
#> 3         Chester 13lbs. 3oz.   Male 34743774
#> 4         Luthien  4lbs. 6oz. Female 33798929
#> 5         Whisper 8lbs. 13oz.   Male 34716794
#> 6            Stan      11lbs.   Male 34708913
#> 7          Sophie 6lbs. 10oz.   Male 34708876
#> 8          Candee 13lbs. 3oz. Female 34708924
#> 9       Schnitzel 6lbs. 10oz. Female 33109305
#> 10          Smith 6lbs. 10oz. Female 33830316
#> 11         Myrtle 8lbs. 13oz. Female  9018193
#> 12          Casey 13lbs. 3oz. Female 34675343
#> 13         Maggie 8lbs. 13oz. Female 34675262
#> 14          Chloe 8lbs. 13oz. Female 34675334
#> 15 Danica Catrick 6lbs. 10oz. Female 33884615
#> 16          Pablo      11lbs.   Male 15179668
#> 17           Huey 8lbs. 13oz.   Male 34429643
#> 18         Lagoon 8lbs. 13oz. Female 34504499
#> 19         Raquel 6lbs. 10oz. Female  5752934
#> 20          Alvin 8lbs. 13oz.   Male 34521390
#> 21         Sophia 13lbs. 3oz. Female  5752213
#> 22        Mr. Mom 15lbs. 6oz.   Male 34524400
#> 23         Taylor      11lbs.   Male 34541237
#> 24           Alex 15lbs. 6oz.   Male 34541251
#> 25          Fanta      11lbs.   Male 34541235
#> 26          Jesse      11lbs.   Male 34541246
#> 27           Teri      11lbs.   Male 34541241
#> 28        Cheerio  2lbs. 3oz. Female 34556750
#> 29          Tulip      11lbs. Female 23579197
#> 30       Bluebell 13lbs. 3oz.   Male 34659526
#> The fattest cat is Mr. Mom. He weighs 15lbs 6oz.
#> Opening cat profile...
```
