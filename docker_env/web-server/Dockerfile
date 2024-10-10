# FROM php:8.0-fpm

# RUN mkdir -p /var/www/html/images
# RUN chown -R www-data:www-data .
# RUN chmod -R 755 /var/www/html/images

# Start (default command from base image)
# CMD ["nginx", "-g", "daemon off;"]


FROM python:3.12

WORKDIR /app

COPY requirements.txt .

RUN python -m venv /opt/venv

ENV PATH="/opt/venv/bin:$PATH"
RUN pip install -r requirements.txt

COPY . .

CMD ["python", "src/app.py"]

