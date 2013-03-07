BUILD=				build/

CP=					cp 
MV=					mv 
RM=					rm -r
MKDIR=				mkdir

OCAMLBUILD=			ocamlbuild
OCAMLBUILD_FLAGS=	-use-menhir \
					-build-dir $(BUILD) \

NAME=				dinc

all: native byte

build:
	@if [ ! -d $(BUILD) ]; then $(MKDIR) $(BUILD); fi

byte: build
	@$(OCAMLBUILD) $(OCAMLBUILD_FLAGS) $(NAME).byte
	@$(CP) $(BUILD)/$(NAME).byte $(NAME).byte

native: build
	@$(OCAMLBUILD) $(OCAMLBUILD_FLAGS) $(NAME).native
	@$(CP) $(BUILD)/$(NAME).native $(NAME).native

clean:
	@$(OCAMLBUILD) -clean
	@if [ -f $(NAME).native ]; then $(RM) $(NAME).native; fi
	@if [ -f $(NAME).byte ]; then $(RM) $(NAME).byte; fi
	@if [ -d $(BUILD) ]; then $(RM) $(BUILD); fi

re: clean all
