/**
  * NewLand Kernel - (C) 2019 Tristan Ross
  */
#pragma once

typedef int (*modinit_t)();
typedef void (*modfini_t)();

typedef struct {
  const char id[128];
  const char author[256];
  const char license[256];
  const char modver[24];
  const char krnlver[24];
  modinit_t init;
  modfini_t fini;
} modinfo_t;

#ifdef NEWLAND_MODULE
#define MODULE_INIT(id) static int init()
#define MODULE_FINI(id) static void fini()
#define MODULE(id, author, license, modver) modinfo_t modinfo __attribute__((section(".modinfo"))) = { #id, author, license, modver, "0.1.0", init, fini }
#else
#define MODULE_INIT(id) static int kmod_## id ##_init()
#define MODULE_FINI(id) static void kmod_## id ##_fini()
#define MODULE(id, author, license, modver) modinfo_t kmod_## id __attribute__((section(".modinfo"))) = { #id, author, license, modver, "0.1.0", kmod_## id ##_init, kmod_## id ##_fini }
#endif
