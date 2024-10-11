from flask import Flask
from flask import render_template
from flask import request
# from flask import Markup

app = Flask(__name__)
reviews: list[str] = [  "Best park ever!!!! Had the best time of my life. Everything was perfect, food, rides, people, all of it. 10/10", 
                        "Ok for it's money I guess", 
                        "The cardboard ride of my 5 year old son gives you more adrenaline, than whatever you put there.", 
                        "Meh", 
                        "You suck. -3/5"]

@app.route("/")
def index():
   return render_template('index.html')


@app.route("/review", methods = ['GET', 'POST'])
def review():
    if request.method == 'POST':
        new_review = request.form.get("review-txt", None)
        if new_review:
            reviews.append(new_review)
    return render_template('review.html', reviews=reviews)


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)

