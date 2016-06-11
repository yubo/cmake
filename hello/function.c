/*
 * Copyright 2015 Xiaomi Corporation. All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 *
 * Authors:    Yu Bo <yubo@xiaomi.com>
 */
/*
 *  hello-function.c - The simplest kernel module.
 */
#include <linux/module.h>   /* Needed by all modules */
#include <linux/kernel.h>   /* Needed for KERN_ALERT */

void function_hello(void)
{
    printk("<1>Hello world function.\n");
}

