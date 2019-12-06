# Gitlab extracter

The aim of this project is to offer a simple interface to extract data from a gitlab project.

## Implementation

This project is currently issuing HTTP GET requests to gitlab API in order to retrieve project's content.

## Retrieving content as JSON

The script used to retrieve Gitlab project's issues is **gitlab-extracter**.

This script retrieve Gitlab project issues from its from project's id.

    Usage: ./gitlab-extracter --id PROJECT_ID [-h|--help] [-a|--auth KEY] [-b|--browse] [-o|--output OUTPUT.json] [-u|--url URL] [--no-proxy]
    		-h|--help                       : Print help.
    		-a|--auth                       : Authentication key 
    		-b|--browse                     : Open JSON content with default web browser. 
    		-i|--id                         : Gitlab project id. 
    		-o|--output                     : Save JSON content into given file. 
    		-u|--url                        : Gitlab server URL ('https://gitlab.com' as default value).
    		--no-proxy                      : Don't use proxies, even if the appropriate *_proxy environment variable is defined.


    Retrieve gitlab project's content as JSON file. 
              	The content is either stored in a file or printed on standard output. 
              	The JSON content can also be oppened into a web browser.
              	
              	NOTE : 'curl' package has to be installed.


### Authentication

Currently, the only supported authentication method is using **Personal access tokens**.

Please refer to [Gitlab API documentation](https://docs.gitlab.com/ee/user/profile/personal_access_tokens.html) in order to configure acces to private projects.

## Converting JSON to CSV

The script used to convert JSON project content to a CSV file is **json2csv**.

    ###################
    ### Description ###
    ###################
    Convert Gitlab JSON issues to a CSV file using 'jq'.
    	Issues can be filtered either by using predefined filters or by composing it with available options.
    	The output pattern can also be chosen from the predefined ones or composed with options.

    	NOTE : 'jq' Debian package has to be installed.
    #############
    ### Usage ###
    #############
    Usage: ./json2csv [-h|--help] [OPTIONS]
    Options:
    	-h|--help                       : Print this help.
    	-i|--input                      : Input JSON file. If not specified, JSON is read from stdin.
    	-o|--output                     : Output CSV file. If not specified, CSV is printed on stdout.
    	-s|--csv-separator              : The character separator to be used in the CSV output file. If not specified, ';' is used.
    	--no-header                     : Do not print CSV header.
    	--filter                        : Keep results matching filter.
    	--filter-out                    : Remove results matching filter.
    	--model                         : Compose output format using predefined attributes.
    	--format                        : Attributes are printed following the given format.
    	--print-attributes              : Print available attributes for printing and filtering.
    	--print-models                  : Print available models for printing.
    #####################
    ### Output format ###
    #####################
    Composing models with predefined attributes: (--model <MODEL>)

    	Output format follows the order of given attributes and uses the CSV separator.

    	 - assigne                   The person who has been assigned to the issue.
    	 - author                    The issue's author.
    	 - creation-date             Issue's creation date.
    	 - description               Issue's description.
    	 - due-date                  Issue's end date.
    	 - id                        Issue's id.
    	 - labels                    Issue's labels.
    	 - milestone                 Issue's milestone.
    	 - state                     Issue's current state.
    	 - title                     Issue's title.

    	MODEL format: --model attr1,attr2,attr3

    Predefined models: (--model-MODELNAME)

    	Predefined models use CSV separator between attributes.

    	 --model-title               Print only title
    	 --model-id-title            Print id and title
    	 --model-id-title-labels     Print id, title and labels
    	 --model-title-desc          Print title and description
    	 --model-id-title-desc       Print id, title and description
    	 --model-all                 Print all attributes in the following order: id, title, state, milestone, labels, assigne, author, creation-date and description

    With given format: (--format <FORMAT>)

    	Selected attributes are printed following the given format, the CSV separator is not used.
    ###############
    ### Filters ###
    ###############
    Filters' attributes shall be choosen from predefined attributes.

    Filter format:
    	attribute=value   ==>  Attribute is equal to value
    	attribute[value]  ==>  Attribute contains value (for lists)

## More to come...

 - Allow user to load its own attributes and models from a configuration file
 - OAuth2 authentication
 - Session cookie identification
 - Handle and detail HTTP return codes
