/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: mlantonn <mlantonn@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/23 17:49:38 by mlantonn          #+#    #+#             */
/*   Updated: 2018/06/29 04:47:30 by mlantonn         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "rtv1.h"
#include "ui.h"
#include <time.h>//
#include "libft.h"//

void			get_time(void)
{
	static int						time;
	static struct timespec			last;
	struct timespec					tmptime;

	if (!last.tv_nsec)
		clock_gettime(CLOCK_MONOTONIC_RAW, &last);

	clock_gettime(CLOCK_MONOTONIC_RAW, &tmptime);
	if (time != 0)
	{
		printf("temps de calcul : %f seconde\n", \
				((tmptime.tv_sec - last.tv_sec) * 1000000000 + \
				 (tmptime.tv_nsec - last.tv_nsec)) * pow(10, -9));
	}
	time++;
}

static int ft_exit(void)
{
	ft_putendl("Usage : ./rt \'file_name\'");
	return (0);
}

int		main(int ac, char **av)
{
	if (ac != 2 || ft_strlen(av[1]) < 1)
		return (ft_exit());
	g_data = data_init(ac, av);
	get_oc();
//	g_data->objs[0].shiny = 1;
//	g_data->objs[0].shin_pourcentage = 1;
	gtk_init(&ac, &av);
	ft_putstr("Here Iam");
	if (create_ui(av[0]) == 0)
		return (0);
    ft_putstr("born to became");
	//g_data->aa = 4;
	//g_data->objs[0].tex = pixelbuf_new_from_file("./textures/bricks.png");
	put_gdk_image();
	//print_parsed_data(data);*/
	ft_event(g_data);
	return (0);
}
