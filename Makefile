SRC_DIR=source

FOUNDRY_DIR = ../..
PRODUCTION_DIR = ${FOUNDRY_DIR}/scripts
DEVELOPMENT_DIR = ${FOUNDRY_DIR}/scripts_
MODULARIZE = ${FOUNDRY_DIR}/build/modularize
UGLIFY = uglifyjs --unsafe -nc
UGLIFYCSS = uglifycss

all: premake body buttons thumbs min buttons-min thumbs-min

premake:
	mkdir -p ${DEVELOPMENT_DIR}/fancybox
	mkdir -p ${PRODUCTION_DIR}/fancybox

body:
	${MODULARIZE} -n "fancybox" -css "fancybox/default" ${SRC_DIR}/jquery.fancybox.js > ${DEVELOPMENT_DIR}/fancybox.js
	cp ${SRC_DIR}/*.gif ${SRC_DIR}/*.png ${DEVELOPMENT_DIR}/fancybox/
	cp ${SRC_DIR}/jquery.fancybox.css ${DEVELOPMENT_DIR}/fancybox/default.css

buttons:
	${MODULARIZE} -n "fancybox/buttons" -css "fancybox/buttons" ${SRC_DIR}/helpers/jquery.fancybox-buttons.js > ${DEVELOPMENT_DIR}/fancybox/buttons.js
	cp ${SRC_DIR}/helpers/fancybox_buttons.png ${DEVELOPMENT_DIR}/fancybox/fancybox_buttons.png
	cp ${SRC_DIR}/helpers/jquery.fancybox-buttons.css ${DEVELOPMENT_DIR}/fancybox/buttons.css

thumbs:
	${MODULARIZE} -n "fancybox/thumbs" -css "fancybox/thumbs" ${SRC_DIR}/helpers/jquery.fancybox-thumbs.js > ${DEVELOPMENT_DIR}/fancybox/thumbs.js
	cp ${SRC_DIR}/helpers/jquery.fancybox-thumbs.css ${DEVELOPMENT_DIR}/fancybox/thumbs.css

min:
	${UGLIFY} ${DEVELOPMENT_DIR}/fancybox.js > ${PRODUCTION_DIR}/fancybox.js
	cp ${SRC_DIR}/*.gif ${SRC_DIR}/*.png ${PRODUCTION_DIR}/fancybox/
	${UGLIFYCSS} ${SRC_DIR}/jquery.fancybox.css > ${PRODUCTION_DIR}/fancybox/default.css

buttons-min:
	${UGLIFY} ${DEVELOPMENT_DIR}/fancybox/buttons.js > ${PRODUCTION_DIR}/fancybox/buttons.js
	cp ${SRC_DIR}/helpers/fancybox_buttons.png ${PRODUCTION_DIR}/fancybox/fancybox_buttons.png
	${UGLIFYCSS} ${SRC_DIR}/helpers/jquery.fancybox-buttons.css > ${PRODUCTION_DIR}/fancybox/buttons.css

thumbs-min:
	${UGLIFY} ${DEVELOPMENT_DIR}/fancybox/thumbs.js > ${PRODUCTION_DIR}/fancybox/thumbs.js
	${UGLIFYCSS} ${SRC_DIR}/helpers/jquery.fancybox-thumbs.css > ${PRODUCTION_DIR}/fancybox/thumbs.css

clean:
	rm -fr ${DEVELOPMENT_DIR}/fancybox.js
	rm -fr ${DEVELOPMENT_DIR}/fancybox
	rm -fr ${PRODUCTION_DIR}/fancybox.js
	rm -fr ${PRODUCTION_DIR}/fancybox
