from flask import Flask, render_template, request, redirect, url_for, jsonify

app = Flask(__name__)
reviews: list[str] = [  "Best park ever!!!! Had the best time of my life. Everything was perfect, food, rides, people, all of it. 10/10", 
                        "Ok for the money I guess", 
                        "The cardboard ride of my 5 year old son gives you more adrenaline, than whatever you put there.", 
                        "Meh", 
                        "You suck. -3/5"]

@app.route("/")
def index():
   return render_template('index.html')


@app.route("/review", methods = ['GET', 'POST'])
def review():
    global reviews
    if request.method == 'POST':
        new_review: str = request.form.get("review-txt", None)
        if "script" in new_review:
            reviews.append("*This text was replaced because a script tag was detected*") 
        elif new_review:
            reviews.append(new_review)
    return render_template('review.html', reviews=reviews)



@app.route("/delete-my-reviews", methods = ['GET'])
def delete_my_reviews():
    global reviews
    reviews = reviews[:5]

    return redirect(url_for('review'))


@app.route("/getSensitiveInformation", methods = ['GET'])
def get_sensitive_information():
    global reviews
    credentials = "bob:very_secure_passwd"
    d = {"resp":"it seems like you made this request manually, because it wasn't triggered by the html content"}

    if len(reviews) > 5:
        for user_review in reviews:
            if "getSensitiveInformation()" in user_review:
                d['resp'] = credentials

    return jsonify(d)


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)

