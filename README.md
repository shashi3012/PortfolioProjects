# PROJECT : MOVIE CORRELATION IN PYTHON

![Movie Revenue Correlation](https://i1.wp.com/www.wonderslist.com/wp-content/uploads/2018/12/Highest-Grossing-Hollywood-Movies.jpg?fit=1200%2C675&ssl=1)

# Description : 

In this project, I worked in Python to find correlations between our dependent variables, gross revenue, and other movie feature variables.

# Motivation :

Is the movie industry dying? Is Netflix the new entertainment king? Those were the first questions that lead me to create a dataset
focused on movie revenue and analyze it over the last decades. But, why stop there? There are more factors that intervene in this
kind of thing, like actors, genres, user ratings and more.

# Data :

The data I used was found on [Kaggle](https://www.kaggle.com/danielgrijalvas/movies "Kaggle"). This dataset focuses on movie revenue over the last decade(s). There are 6820 movies in the dataset (220 movies per year, 1986-2016). Each movie has the following attributes:

budget: the budget of a movie. Some movies don't have this, so it appears as 0
company: the production company
country: country of origin
director: the director
genre: main genre of the movie.
gross: revenue of the movie
name: name of the movie
rating: rating of the movie (R, PG, etc.)
released: release date (YYYY-MM-DD)
runtime: duration of the movie
score: IMDb user rating
votes: number of user votes
star: main actor/actress
writer: writer of the movie
year: year of release

# Assumptions :
We will use gross revenue for films as our dependent variable (y). There could be many variables from the above list that predict gross revenue. We want to find the independent, or predictor, variables (x) that are correlated with gross revenue out of the list shown above. When we identify the predictor variables, we will then look at what kind of correlation the variables have: negative or positive correlation, and we will inidicate an intensity: low, moderate, or high correlation.

Before I start the analysis, I predict that the variables budget and company will both be highly correlated with gross revenue for films. At this point in time, I do not know if those two variables are correlated with but thanks to the analysis, we will be able to find out what variables actually influence gross revenue.

# Conclusion :
After cleaning the data, made sure there are no duplicates, and coded string variable values to categorical values (unique identifiers) to run the analysis.
I found I was 50% correct in my assumption: It appears the variables budget and votes have the highest, positive correlation to gross revenue while company has a low positive correlation.

