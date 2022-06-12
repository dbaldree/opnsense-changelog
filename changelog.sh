#!/bin/sh
CURDIR=$(dirname $0)
DOCSDIR=community
DOCS=$(find -L ${DOCSDIR} -type f)
#echo $DOCS
WEBIFY=${CURDIR}/scripts/webify.pl
WORKDIR=${CURDIR}/work
#cleanup work folder 1st
rm -f ${WORKDIR}/*
echo '[' > ${WORKDIR}/index.json
for DOC in ${DOCS}
do
${WEBIFY} ${CURDIR}/${DOC} > \
${WORKDIR}/${DOC:C/.*\///1}.htm 2>> ${WORKDIR}/index.json
${WEBIFY} ${CURDIR}/${DOC} text > \
${WORKDIR}/${DOC:C/.*\///1}.txt
echo ${DOC}
if [ ${DOC}!=${DOCS} ]; then
 echo ',' >> ${WORKDIR}/index.json
fi
done
echo ']' >> ${WORKDIR}/index.json
tar -C ${WORKDIR} --exclude="^.gitignore" -cJf changelog.txz .
