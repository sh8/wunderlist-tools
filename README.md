# wunderlist-tools
you can manage your tasks more dramatically with this tools.

## Requisition
I assume this tools will be used with heroku(heroku.com) and its scheduler addon(https://elements.heroku.com/addons/scheduler) or cron.
Therefore you need to install following libraries.

* ruby (>= 2.0.0) 
* wunderlist-api (>= 0.7.1)
* rake
* rack

## Usage

### SETUP
With heroku

1. create your credential file at same directory as Rakefile (credentials.yaml)

  ``` credentials.yaml
  :access_token: <your access token>
  :client_id: <your client id>
  ```

2. register heroku (https://signup.heroku.com/identity)

3. run below command
  
  ```
  $ bundle install
  ```

4. create heroku application
  
  ```
  $ heroku create 
  ``` 
5. push your tools into heroku

  ```
  $ git push heroku master
  ```

6. install scheduler addon
   (you have to register your credit card in heroku.)

  ```
  $ heroku addons:add scheduler
  $ heroku addons:open scheduler
  ```

6. set your command in scheduler's page
  
  ```
  $ rake hogehoge
  ```

### Wunerlist RSS

1. set RSS feed urls at wunderlist-rss/rss_urls.yaml

2. set your list name at app.rb:8 

3. run below command
  
  ```
  $ rake get articles
  ```

## LICENSE
[MIT](https://github.com/shun3475/wunderlist-tools/blob/master/LICENSE)

## AUTHOR
[shun3475](https://github.com/shun3475)
