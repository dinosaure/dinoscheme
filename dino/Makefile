CC=				clang
IDIR=			include
LDIRS=			
LFLAGS=			$(LDIRS)
CFLAGS=			-I $(IDIR) -W -Wextra -Wall -g
RM=				rm -f

NAME=			dino

SRC=			src/main.c \
				src/register.c \
				src/primitive.c \
				src/util.c \
				src/memory.c \
				src/vm.c \

OBJ=			$(SRC:.c=.o)

all: $(NAME)

$(NAME):	$(OBJ)
	@$(CC) $(OBJ) -o $(NAME) $(CFLAGS) $(LFLAGS)
	@echo " CC	$(OBJ)"

%.o: %.c
	@$(CC) -c $< -o $@ $(CFLAGS)
	@echo " CC	$<"

clean:
	@$(RM) $(OBJ)
	@echo " RM	$(OBJ)"

fclean: clean
	@$(RM) $(NAME)
	@echo " RM	$(NAME)"

re: fclean all

.PHONY: clean fclean re
