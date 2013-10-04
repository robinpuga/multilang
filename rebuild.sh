#!/bin/bash
BASEDIR=`php -r "echo dirname(realpath('$0'));"`
OLDDIR=`pwd`
cd $BASEDIR

# Create backup directories, if they don't exist yet.
mkdir -p bak_contrib/{modules,themes}

# Move all things about to get rebuild to backup directory.
for contrib in modules/contrib modules/development themes/contrib libraries translations
do
  mv -f $contrib bak_contrib/$contrib
done

# Result of last tried operation, also used as flag for skipping subsequent steps.
LAST_RETURN_VALUE=0

# Run drush make
if [ $LAST_RETURN_VALUE -eq 0 ]; then
  drush make --yes --working-copy --no-core --contrib-destination=. --translations=de multilang.make
  LAST_RETURN_VALUE=$?
  if [ $LAST_RETURN_VALUE -ne 0 ]; then
    echo "There was a problem with drush make."
  fi
fi

# step 2
if [ $LAST_RETURN_VALUE -eq 0 ]; then
  ./copy_and_patch_locally.sh
  LAST_RETURN_VALUE=$?
  if [ $LAST_RETURN_VALUE -ne 0 ]; then
    echo "There was a problem with local patches."
  fi
fi

# Decide whether to roll back or not.
if [ $LAST_RETURN_VALUE -eq 0 ]; then
  echo "Everything was fine in $0"
  rm -rf bak_contrib
  echo "Contrib backups deleted."
else
  echo "There was a problem."
  # Things went wrong - back-up from bak_contrib
  if [ -n `which rsync` ]; then
    rsync -av bak_contrib/ .
    LAST_RETURN_VALUE=$?
    if [ $LAST_RETURN_VALUE -eq 0 ]; then
      rm -rf bak_contrib
      echo "Contrib backups have been rolled back."
    else
      echo "There was a problem during roll back. Backups have been left intact."
    fi
  fi
fi

# sync DB to new code, but no auto-confirmation commandline switch ( "--yes" )
# in order to leave the choice to the user.
// drush updb

# Go back where we came from.
cd $OLDDIR
