# Brightcoders Admin
This is a ruby on rails application made to work as an administrator of brightcoders where users can handle courses, students and mint nfts to the students.

## User flows
- Can login into the app using google account.
- Can manage courses.
- Can manage students
- Can mint NFTs to students.

## Authentication restrictions
- Only users that have magmalabs domain email can authenticate.
- Only created users in db can authenticate.
- Users can be created in database with rake task:
    ```bash
    rake user:create['user@magmalabs.io','google_oauth2']
    ```

## Getting Started
This apps have all the logic to manage courses and students, but the minting logic lives in another repository that was added as a submodule in this project.

To fetch the module run:
```bash
git submodule update --init --recursive
```

after that you should see a folder named "contracts", this have all the logic and scripts to deploy and mint contracts.

Now lets set env variables that are used by this app and the submodule app.

Please take a look into .env.example

Set ENV variables in .env file:
```bash
# Rails app
RAILS_ENV
GOOGLE_CLIENT_ID
GOOGLE_CLIENT_SECRET
CONTRACT_ADDRESS
CONTRACT_NETWORK
CONTRACT_REPO_PATH
OPENSEA_BASE_URL

# Submodule app
POLYGON_URL
MUMBAI_URL
PRIVATE_KEY
POLYGONSCAN_API_KEY
COINMARKETCAP_API_KEY
NFT_STORAGE_API_KEY
```

Here is a QA document related to the submodule repository, here you can find info about the env variables from this module https://docs.google.com/document/d/1p4V31ksnwFCrgQLQzT8ch9bqycjTbn7gH6hhJaV7o5g/edit?usp=sharing.

## Now we can run the development server:

```bash
rails db:create
rails db:migrate
rails server
```

Open [http://localhost:3000](http://localhost:3000) with your browser to see the result.

## Deploy on Heroku
This application has a Docker file that is used for deployments to heroku.

This is the pipeline where we have staging and production: https://dashboard.heroku.com/pipelines/4d4dec5d-e065-4dd7-9b87-7b202e03122a

Now, how to make a deploy?
- You need to build the docker image first with
```bash
docker build -t brightcoders-admin .
```
- Now you can push the image to heroku container
```bash
heroku container:push web -a brightcoders-admin-$env # Replace $env with desired environment
```
- And finally you can make the release of the app
```bash
heroku container:release web -a brightcoders-admin-$env # Replace $env with desired environment
```

Note: Dotenv is only working for development so you have to ensure env variables are set in heroku environment. You can do this through the interface in the website or through the cli.

