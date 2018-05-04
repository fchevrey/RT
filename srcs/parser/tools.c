/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   tools.c                                            :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: mlantonn <mlantonn@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/05/03 17:46:20 by mlantonn          #+#    #+#             */
/*   Updated: 2018/05/04 16:22:49 by mlantonn         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "parse.h"

int		read_quotes(char *str, char *word, int *index)
{
	int i;

	i = 0;
	while (str[i] && word[i])
	{
		if (str[i] != word[i])
			return (0);
		++i;
	}
	*index += i;
	return (1);
}

t_vec	parse_vec(char *str, int *index)
{
	t_vec	ret;
	int		i;

	i = 0;
	while (str[i] != '[')
		++i;
	ret.x = my_atof(str + (++i));
	while (str[i] != ',')
		++i;
	ret.y = my_atof(str + (++i));
	while (str[i] != ',')
		++i;
	ret.z = my_atof(str + (++i));
	while (str[i] != ']')
		++i;
	*index += i;
	return (ret);
}

t_color	parse_color(char *str, int *index)
{
	t_color	ret;
	int		i;

	ret.c = 0;
	i = 0;
	while (str[i] != '[')
		++i;
	ret.argb.r = ft_atoi(str + (++i));
	while (str[i] != ',')
		++i;
	ret.argb.g = ft_atoi(str + (++i));
	while (str[i] != ',')
		++i;
	ret.argb.b = ft_atoi(str + (++i));
	while (str[i] != ']')
		++i;
	*index += i;
	return (ret);
}

double	parse_nb(char *str, int *index)
{
	int i;

	i = 0;
	while (str[i] != ':')
		++i;
	*index += i;
	return (my_atof(str + i + 1));
}
