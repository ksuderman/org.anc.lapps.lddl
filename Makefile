## CHANGE. This is the startup script that will be generated. This path can
## point anywhere, but should be on your (the user's) default $PATH.
BIN=$(HOME)/bin/lddl

help:
	@echo
	@echo "GOALS"
	@echo
	@echo "jar     : builds the jar file."
	@echo "skip    : builds the jar file skipping the test phase."
	@echo "test    : runs the unit tests."
	@echo "zip     : creates the distribution zip file."
	@echo "install : copies the jar and startup script to ~/bin"
	@echo "scripts : creates a zip archive of the script files."
	@echo "version : generates the VERSION file."
	@echo "clean   : deletes all build artifacts."
	@echo
	
jar:
	mvn anc:version
	mvn package

skip:
	mvn -DskipTests=true package
	
install:
	$(eval version := $(shell cat VERSION))
	echo "Copying LDDL-"${version}".jar"
	cp target/LDDL-$(version).jar ~/bin
	#cp target/LDDL-$(version).jar dist
	echo "Generating startup script."
	cat src/main/resources/lddl | sed -e 's|__VERSION__|'$(version)'|' > $(BIN)
	if [ -e /Volumes/share ] ; then \
		cp $(HOME)/bin/lddl /Volumes/share ; \
		cp target/LDDL-$(version).jar /Volumes/share ; \
	fi

scripts:
	./scripts.sh
	
version:
	mvn anc:version

zip:
	$(eval version := $(shell cat VERSION))
	$(eval zipfile := LDDL-$(version).zip)
	$(eval jarfile := LDDL-$(version).jar)
	if [ -e $(zipfile) ] ; then rm $(zipfile) ; fi
	if [ -e $(jarfile) ] ; then rm $(jarfile) ; fi
	cp target/$(jarfile) .
	zip $(zipfile) $(jarfile) LICENSE README.md
	cp $(zipfile) LDDL-latest.zip
	rm $(jarfile)
	anc-put $(zipfile) /home/www/anc/downloads
	anc-put LDDL-latest.zip /home/www/anc/downloads
	if [ -e /Volumes/share ] ; then \
		cp $(zipfile) /Volumes/share ; \
	fi
		
clean:
	mvn clean
	rm -f VERSION
	rm -f *.jar
	rm -f *.zip


