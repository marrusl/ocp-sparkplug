podman = $(shell which podman || which docker)
.PHONY: info
info:
	@echo "See the README.md"

.PHONY: clean
clean:
	rm -rvf *ign *yaml

.PHONY: luks
luks: clean
	bash luks/mkcfg.sh ign > ${PWD}/rendered.yaml
	${podman} run -it --rm -v ${PWD}:/workdir mikefarah/yq yq merge rendered.yaml luks/raid.yaml \
		> fcct.yaml
	touch ${PWD}/raid-luks.ign
	${podman} run -it --rm -v ${PWD}/raid-luks.ign:/fcct.ign:z -v ${PWD}/fcct.yaml:/fcct.yaml:z \
		quay.io/coreos/fcct:release --pretty --output /fcct.ign /fcct.yaml
	@echo "Outputed config to raid-luks.ign"

.PHONY: mco-luks
mco-luks: clean

	@bash luks/mkcfg.sh > ${PWD}/99-luks-on-raid.yaml
	@echo "Use luks/raid.yaml for for you ignition payload"
	@echo "Run 'oc apply 99-luks-on-raid.yaml' to create the MCO config"
