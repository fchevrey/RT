/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   vec.h                                              :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: mlantonn <mlantonn@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/06/04 16:01:18 by mlantonn          #+#    #+#             */
/*   Updated: 2018/06/19 23:56:02 by mlantonn         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef VEC_H
# define VEC_H

# include <math.h>
# include "structs.h"

/*
**	Functions to call for each ray.
*/
t_vec	compute_ray(t_vec vp);
int		hit(t_data *data, t_vec ray, t_inter *inter);

/*
**	Intersection functions.
*/
int		intersect_sphere(t_obj sphere, t_vec ray, t_inter *inter);
int		intersect_plane(t_obj plane, t_vec ray, t_inter *inter);
int		intersect_cylinder(t_obj sphere, t_vec ray, t_inter *inter);
int		intersect_cone(t_obj plane, t_vec ray, t_inter *inter);

/*
**	Functions to get the normal of the objects at the intersection point.
*/
t_vec	get_normal(t_vec ray, t_obj obj, t_inter inter);
t_vec	get_sphere_normal(t_obj sphere, t_inter inter);
t_vec	get_plane_normal(t_obj plane, t_inter inter);
t_vec	get_cylinder_normal(t_obj cyl, t_inter inter);
t_vec	get_cone_normal(t_obj cone, t_inter inter);

/*
**	Vector operations.
*/
t_vec	vec_add(t_vec u, t_vec v);
t_vec	vec_substract(t_vec u, t_vec v);
t_vec	vec_multiply(t_vec u, double t);
double	vec_cos(t_vec u, t_vec v);
t_vec	vec_cross_product(t_vec u, t_vec v);

/*
**	Vector operations 2.
*/
t_vec	vec_normalize(t_vec u);
double	get_length(t_vec u);
double	dot_product(t_vec u, t_vec v);

/*
** Rotations
*/
void	rotate_around_point(t_data *data, t_vec pt, t_vec angle);
t_vec	pitch(t_vec ray, t_vec angle);
t_vec	yaw(t_vec ray, t_vec angle);

void	get_vp_up_left(t_camera *cam);
void	get_oc(void);

#endif