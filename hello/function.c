/*
 *  hello-function.c - The simplest kernel module.
 */
#include <linux/module.h>   /* Needed by all modules */
#include <linux/kernel.h>   /* Needed for KERN_ALERT */

void function_hello(void)
{
    printk("<1>Hello world function.\n");
}

