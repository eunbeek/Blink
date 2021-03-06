{ echo "
git stash -q --keep-index
mvn spotbugs:check
RESULTS=\$?
# Perform checks
git stash pop -q
if [ \$RESULTS -ne 0 ]; then
  echo
  echo
  echo [Error]: Lint checks failed. Please fix the issues and commit. 
  echo [Run]: \"mvn spotbugs:gui\" to view the bugs in GUI mode.
  echo
  exit 1
fi
# You shall commit
echo [Formatting Code]
mvn spotless:check
exit 0"
} > pre-commit.sh
pushd .git/hooks
ln -s ../../pre-commit.sh pre-commit
chmod u+x pre-commit
popd
