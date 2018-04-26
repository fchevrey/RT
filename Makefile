# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: pmiceli <pmiceli@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2018/02/28 17:43:26 by pmiceli           #+#    #+#              #
#    Updated: 2018/04/26 17:27:45 by pmiceli          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = rt
DIR_NAME = RT

## color ##
RED = \033[31m
GRE = \033[32m
YEL = \033[33m
BLU = \033[34m
MAG = \033[35m
CYA = \033[36m
EOC = \033[37m

## sources ##
SRCDIR = ./srcs/
SRCNAMES  = draw/draw_image.c \
			\
			init/data_init.c \
			init/img_init.c \
			init/t_mlx_init.c \
			\
			vec/get_normal.c \
			vec/intersect.c \
			vec/shadow_ray.c \
			vec/vec_operations.c \
			vec/vec_operations2.c \
			\
			exit_all.c \
			main.c
SRC = $(addprefix $(SRCDIR), $(SRCNAMES))

## LIB DIR ##
LIB_DIR = ./lib
LIBFT_DIR = $(LIB_DIR)/libft/
MLX_DIR = $(LIB_DIR)/mlx_sierra/
LIBMYSDL_DIR = $(LIB_DIR)/libmysdl/
LIBPT_DIR = $(LIB_DIR)/libpt/
SLD2 = $(LIB_DIR)/SDL2-2.0.8/

## Includes ##
INC = ./includes/
INCS = ./includes/rtv1.h
LIB_INCS = $(LIBFT_DIR)/includes/get_next_line.h $(LIBFT_DIR)/includes/libft.h\
		   $(MLX_DIR)/includes/mlx.h

## OBJECTS ##
OBJS_DIR = ./objs/
OBJS = $(addprefix $(OBJS_DIR), $(SRCNAMES:.c=.o))

## FLAGS ##
CC = gcc
CFLAGS = -Wall -Wextra -Werror
MLX_FLAGS = -framework OpenGL -framework AppKit
LFLAGS =	-L $(LIBFT_DIR) -lft \
			-L $(MLX_DIR) -lmlx $(MLX_FLAGS) \
			-L $(LIBPT_DIR) -lpt

PRINT = "make[1]: Nothing to be done for \'all\'."
PRINT2 = "make[1]: Nothing to be done for \'all\'."

all: LIBFT MLX PT SDL2 MYSDL $(NAME) print_done

change_cflag:
	$(eval CFLAGS = -fsanitize=address)

MODE_DEBUG: change_cflag all

$(NAME): print_name $(OBJS)
	@$(CC) $(CFLAGS) -o $(NAME) $(OBJS) $(LFLAGS)
	@echo "$(PRINT2)"

$(OBJS): $(OBJS_DIR)%.o:$(SRCDIR)%.c $(INCS) $(LIB_INCS)
	@$(eval PRINT2 = "")
	@echo "\033[038;2;255;153;0m⧖\tCreating\t$@\033[0m"
	@mkdir -p $(@D)
	@$(CC) $(CFLAGS) -I$(INC) -o $@ -c $<

LIBFT: print_libft
	@make -C $(LIBFT_DIR)

MLX: print_mlx
	@make -C $(MLX_DIR)

PT: print_libpt
	@make -C$(LIBPT_DIR)

MYSDL: print_libmysdl
	@make -C $(LIBMYSDL_DIR)

SDL2: print_sdl2
ifeq ("$(wildcard $(HOME)/LIBS/SDL2/lib/libSDL2.dylib)","")
	@mkdir -p ~/LIBS/SDL2
	@make -C $(SDL2_DIR) clean
	@cd $(SDL2_DIR) && ./configure --prefix=$(HOME)/LIBS/SDL2
	@make -C $(SDL2_DIR)
	@make -C $(SDL2_DIR) install
else
	@echo "make[1]: Nothing to be done for 'all'."
endif

rm_obj:
	@rm -rf $(OBJS_DIR)
	@echo "❌\t\033[031m$(DIR_NAME)'s objects removed\033[0m"

clean: rm_obj
	@make -C $(LIBFT_DIR) clean
	@make -C $(LIBPT_DIR) clean
	@make -C $(MLX_DIR) clean
	@make -C $(LIBMYSDL_DIR) clean

fclean: rm_obj
	@rm -rf $(NAME)
	@echo "❌\t\033[031m$(DIR_NAME)'s executable removed\033[0m"
	@make -C $(LIBFT_DIR) fclean
	@make -C $(LIBPT_DIR) fclean
	@make -C $(MLX_DIR) fclean
	@make -C $(LIBMYSDL_DIR) fclean

re: fclean all

exe: rm_obj $(NAME)

re_MODE_DEBUG: fclean MODE_DEBUG

alias:
	echo "alias maked=\"make MODE_DEBUG\"" >> $(HOME)/.zshrc
	echo "alias makerd=\"make re_MODE_DEBUG\"" >> $(HOME)/.zshrc
	echo "alias md=\"make MODE_DEBUG\"" >> $(HOME)/.zshrc
	echo "alias mrd=\"make re_MODE_DEBUG\"" >> $(HOME)/.zshrc

ret : clean test

print_name:
	@echo "\033[033m➼\t\033[033mCompiling $(DIR_NAME) ... with flag :\033[36m $(CFLAGS)\033[0m"
	@echo "\033[033m➼\t\033[033mCreating $(DIR_NAME)'s executable\033[0m"

print_libft:
	@echo "\033[033m➼\t\033[033mCompiling Libft ...\033[0m"

print_libmysdl:
	@echo "\033[033m➼\t\033[033mCompiling Libmysdl ...\033[0m"

print_libpt:
	@echo "\033[033m➼\t\033[033mCompiling Libpt ...\033[0m"

print_mlx:
	@echo "\033[033m➼\t\033[033mCompiling Mlx_sierra ...\033[0m"

print_sdl2:
	@echo "\033[033m➼\t\033[033mCompiling SDL2 ...\033[0m"

print_done:
	@echo "\033[032m✓\t\033[032mDONE !\033[0m"
	@echo "\n ========================================\n"

.PHONY: all clean fclean re rm_obj LIBFT MLX PT MYSDL \
	MODE_DEBUG re_MODE_DEBUG change_cflag print_name print_done \
	print_libft print_libmysdl print_libpt print_mlx alias print_sdl2 SDL2
