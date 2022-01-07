#!/usr/bin/env bash

# useful docs are here
# https://docs.gitlab.com/ee/api/job_artifacts.html#get-job-artifacts
# if you're adding this to CI, there's a $CI_JOB_TOKEN

TOKEN=${CI_JOB_TOKEN:-$GITLAB_TOKEN}

# the id can be a number or the path, the path must be url incoded, which using variable sub in the url
# id="28611950"
ID="path/to/project/name"
REF_NAME="master"

# from
JOB="build-fpga"

function usage () {
    echo "usage :  $0 [options] [--]
options:
-h|--help       Display this message

--job           ci job name as defined in .gilab-ci.yml
--id            the project number or path
--ref-name      branch or tag name"

}    # ----------  end of function usage  ----------

while :; do
    case $1 in
         # Takes an jobion argument; ensure it has been specified.
        --job)
            if [ "$2" ]; then
            JOB=$2
            shift
            else
            die 'ERROR: "--job" requires a non-empty option argument.'
            fi
            ;;
        --job=?*)
            JOB=${1#*=} # Delete everything up to "=" and assign the remainder.
            ;;
        # Handle the case of an empty --file=
        --job=)
            echo 'ERROR: "--job" requires a non-empty option argument.'
            exit 1
            ;;

         # Takes an idion argument; ensure it has been specified.
        --id)
            if [ "$2" ]; then
            ID=$2
            shift
            else
            die 'ERROR: "--id" requires a non-empty option argument.'
            fi
            ;;
        --id=?*)
            ID=${1#*=} # Delete everything up to "=" and assign the remainder.
            ;;
        # Handle the case of an empty --file=
        --id=)
            echo 'ERROR: "--id" requires a non-empty option argument.'
            exit 1
            ;;

         # Takes an ref-nameion argument; ensure it has been specified.
        --ref-name)
            if [ "$2" ]; then
            REF_NAME=$2
            shift
            else
            die 'ERROR: "--ref-name" requires a non-empty option argument.'
            fi
            ;;
        --ref-name=?*)
            REF_NAME=${1#*=} # Delete everything up to "=" and assign the remainder.
            ;;
        # Handle the case of an empty --file=
        --ref-name=)
            echo 'ERROR: "--ref-name" requires a non-empty option argument.'
            exit 1
            ;;

        -h|-\?|--help)
            usage; exit 0;; # Display a usage synopsis.
        --)      # End of all options.
            shift
            break
            ;;
        -?*)
            printf 'ERROR: Unknown option (ignored): %s\n' "$1" >&2
            exit 1
            ;;
        *)       # Default case: No more options, so break out of the loop.
            break
    esac

    shift
done

curl --location \
    --output "${JOB}".zip \
    --header "PRIVATE-TOKEN: ${TOKEN}" \
    "https://gitlab.com/api/v4/projects/${ID//\//%2F}/jobs/artifacts/${REF_NAME}/download?job=${JOB}"

