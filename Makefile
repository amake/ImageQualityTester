app_name = ImageQualityTester
app_version = 1.2
bundle_id = org.amake.$(app_name)
imagemagick_dist_url = https://www.imagemagick.org/download/binaries/ImageMagick-x86_64-apple-darwin17.3.0.tar.gz

.PHONY: all app sign zip clean cleanAll

all: app sign zip

app: work/$(app_name).app

zip: dist/$(app_name)-$(app_version).zip

clean:
	rm -rf work dist

cleanAll: clean
	rm -rf vend

work dist vend:
	mkdir -p $(@)

vend/ImageMagick: | vend
	cd $(@D); curl $(imagemagick_dist_url) | tar xvz; mv ImageMagick-* $(@F)

work/%.app: %.sh vend/ImageMagick | work
	platypus \
		--overwrite \
		--name $(*) \
		--droppable \
		--app-version $(app_version) \
		--interface-type 'Droplet' \
		--uniform-type-identifiers 'public.image' \
		--bundle-identifier $(bundle_id) \
		--interpreter-args bash \
		--bundled-file $(wordlist 2,$(words $^),$^) \
		$(<) \
		$(@)

sign: work/$(app_name).app
	if [ ! -z "$(codesign_id)" ]; then codesign -f -s "$(codesign_id)" $(^); fi

dist/%-$(app_version).zip: work/%.app | dist
	cd $(^D); zip -r $(@F) .
	mv $(^D)/$(@F) $(@)
