# Pokemon Base Stat Total (BST) distribution by type & generation

Raincloud plots are a neat way of visualizing distributions by combining the features of a scatterplot, boxplot and (half) violin plot, each component contributing information that the others lack. 

Using a combined dataset courtesy of [Ulrik Thyge Pedersen](https://www.kaggle.com/datasets/ulrikthygepedersen/pokemon-stats) & [Kumar Arnav](https://www.kaggle.com/datasets/arnavvvvv/pokemon-pokedex), I created raincloud plots to visualize the distribution of Pokemon base stat totals (BST) across generations and types.

This repo is intended as a learning resource for those looking to create their own raincloud visualizations. I've included the final dataset and the R code I used to generate these plots (minus some final aesthetic touch-ups I did in Canva), as well as high-quality .svg versions of the final product if you're just interested in saving/sharing the graphic. 

To learn more about {ggrain}, the R package used to create these plots, check out this [repo](https://github.com/njudd/ggrain) and this [vignette](https://cran.r-project.org/web/packages/ggrain/vignettes/ggrain.html). A fun little write-up of this project can be found [here](https://medium.com/@atoziye/cloudy-with-a-chance-of-drizzle-visualizing-pokemon-stat-distributions-with-raincloud-plots-616cfc8c5a4e)
