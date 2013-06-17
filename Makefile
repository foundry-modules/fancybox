all: create-script-folder fancybox submodules

include ../../build/modules.mk

MODULE = fancybox

SOURCE_ASSET_FILES = ${SOURCE_STYLE_FOLDER}/*.gif \
${SOURCE_STYLE_FOLDER}/*.png

TARGET_STYLE_LESS_CONVERTER = sed "s/url('/url('@{foundry_uri}\/fancybox\//g"

fancybox: modularize-script minify-script copy-style minify-style lessify-style copy-assets

submodules:
	make buttons
	make thumbs

submodule-%:
	$(eval MODULE                  = fancybox/$*)
	$(eval SOURCE_SCRIPT_FOLDER    = source/helpers)
	$(eval SOURCE_SCRIPT_FILE_NAME = fancybox-$*)
	$(eval SOURCE_STYLE_FILE_NAME  = fancybox-$*)
	$(eval TARGET_STYLE_FOLDER     = ${FOUNDRY_STYLES_FOLDER}/fancybox)
	$(eval TARGET_STYLE_FILE_NAME  = $*)
	
buttons: submodule-buttons modularize-script minify-script copy-style minify-style lessify-style
	cp ${SOURCE_STYLE_FOLDER}/fancybox_buttons.png ${TARGET_STYLE_FOLDER}/fancybox_buttons.png

thumbs: submodule-thumbs modularize-script minify-script copy-style minify-style lessify-style