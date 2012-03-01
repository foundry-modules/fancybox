include ../../build/modules.mk

MODULE = fancybox
FILENAME = ${MODULE}.js

SOURCE = ${SOURCE_DIR}/jquery.${MODULE}.js

PRODUCTION = ${PRODUCTION_DIR}/${FILENAME}
DEVELOPMENT = ${DEVELOPMENT_DIR}/${FILENAME}
PRODUCTION_FOLDER = ${PRODUCTION_DIR}/${MODULE}
DEVELOPMENT_FOLDER = ${DEVELOPMENT_DIR}/${MODULE}

all: premake body buttons thumbs min buttons-min thumbs-min

premake:
	mkdir -p ${DEVELOPMENT_FOLDER}
	mkdir -p ${PRODUCTION_FOLDER}

body:
	${MODULARIZE} -n "${MODULE}" -css "fancybox/default" ${SOURCE} > ${DEVELOPMENT}
	cp ${SOURCE_DIR}/*.gif ${SOURCE_DIR}/*.png ${DEVELOPMENT_FOLDER}/
	cp ${SOURCE_DIR}/jquery.fancybox.css ${DEVELOPMENT_FOLDER}/default.css

buttons:
	${MODULARIZE} -n "fancybox/buttons" -css "fancybox/buttons" ${SOURCE_DIR}/helpers/jquery.fancybox-buttons.js > ${DEVELOPMENT_FOLDER}/buttons.js
	cp ${SOURCE_DIR}/helpers/fancybox_buttons.png ${DEVELOPMENT_FOLDER}/fancybox_buttons.png
	cp ${SOURCE_DIR}/helpers/jquery.fancybox-buttons.css ${DEVELOPMENT_FOLDER}/buttons.css

thumbs:
	${MODULARIZE} -n "fancybox/thumbs" -css "fancybox/thumbs" ${SOURCE_DIR}/helpers/jquery.fancybox-thumbs.js > ${DEVELOPMENT_FOLDER}/thumbs.js
	cp ${SOURCE_DIR}/helpers/jquery.fancybox-thumbs.css ${DEVELOPMENT_FOLDER}/thumbs.css

min:
	${UGLIFYJS} ${DEVELOPMENT} > ${PRODUCTION}
	cp ${SOURCE_DIR}/*.gif ${SOURCE_DIR}/*.png ${PRODUCTION_FOLDER}/
	${UGLIFYCSS} ${SOURCE_DIR}/jquery.fancybox.css > ${PRODUCTION_FOLDER}/default.css

buttons-min:
	${UGLIFYJS} ${DEVELOPMENT_FOLDER}/buttons.js > ${PRODUCTION_FOLDER}/buttons.js
	cp ${SOURCE_DIR}/helpers/fancybox_buttons.png ${PRODUCTION_FOLDER}/fancybox_buttons.png
	${UGLIFYCSS} ${SOURCE_DIR}/helpers/jquery.fancybox-buttons.css > ${PRODUCTION_FOLDER}/buttons.css

thumbs-min:
	${UGLIFYJS} ${DEVELOPMENT_FOLDER}/thumbs.js > ${PRODUCTION_FOLDER}/thumbs.js
	${UGLIFYCSS} ${SOURCE_DIR}/helpers/jquery.fancybox-thumbs.css > ${PRODUCTION_FOLDER}/thumbs.css

clean:
	rm -fr ${DEVELOPMENT}
	rm -fr ${DEVELOPMENT_FOLDER}
	rm -fr ${PRODUCTION}
	rm -fr ${PRODUCTION_FOLDER}
