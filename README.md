# Gitlab extracter

The aim of this project is to offer a simple interface to extract data from a gitlab project.

## Implementation

This project is currently issuing HTTP GET requests to gitlab API in order to retrieve project's content.

## Content

The project currently consist in a simple script allowing to specify project's id to get associated issues.


    Usage: ./retrieve_content.sh --id PROJECT_ID [-h|--help] [-a|--auth KEY] [-b|--browse] [-o|--output OUTPUT.json] [-u|--url URL] [--no-proxy] [--export-csv CSV_FILE.csv]
    		-h|--help                       : Print help.
    		-a|--auth                       : Authentication key 
    		-b|--browse                     : Open JSON content with default web browser. 
    		-i|--id                         : Gitlab project id. 
    		-o|--output                     : Save JSON content into given file. 
    		-u|--url                        : Gitlab server URL ('https://gitlab.com' as default value).
    		--no-proxy                      : Don't use proxies, even if the appropriate *_proxy environment variable is defined.
    		--export-csv                    : Convert JSON to CSV file which includes main fields.


    Retrieve gitlab project's content as JSON file. 
              	The content is either stored in a file or printed on standard output. 
              	The JSON content can also be oppened into a web browser.
              	
              	NOTE : 'curl' package has to be installed.


## Authentication

Currently, the only supported authentication method is using **Personal access tokens**.

Please refer to [Gitlab API documentation](https://docs.gitlab.com/ee/user/profile/personal_access_tokens.html) in order to configure acces to private projects.

## More to come...
