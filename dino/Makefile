CC=				gcc
CCLEX=		flex
IDIR=			include
LDIRS=			
LFLAGS=		$(LDIRS)
CFLAGS=		-O0 -I $(IDIR) -g
RM=				rm -f

NAME=			dino

LEX=			src/dinoscheme.l

SRC=			$(LEX:.l=.c)

OBJ=			$(SRC:.c=.o)

all: $(NAME)

$(NAME):	$(OBJ)
	@$(CC) $(OBJ) -o $(NAME) $(CFLAGS) $(LFLAGS)
	@echo " CC	$(OBJ)"

%.o: %.c
	@$(CC) -c $< -o $@ $(CFLAGS)
	@echo " CC	$<"

%.c: %.l
	@$(CCLEX) -o $@ $<
	@echo " LX	$<"

clean:
	@$(RM) $(SRC:.c=.o) $(LEX:.l=.c)
	@echo " RM	$(OBJ)"

fclean: clean
	@$(RM) $(NAME)
	@echo " RM	$(NAME)"

re: fclean all

.PHONY: clean fclean re

.PRECIOUS: src/dinoscheme.c
