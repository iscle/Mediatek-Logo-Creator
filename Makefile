BOOT_LOGO := fhd
LOGO_IMAGE := logo.bin

BIN_DIR := bin
RES_DIR := res
TMP_DIR := tmp

BMP_TO_RAW := $(BIN_DIR)/bmp_to_raw
ZPIPE := $(BIN_DIR)/zpipe
MKIMAGE := $(BIN_DIR)/mkimage
IMG_HDR_CFG := $(RES_DIR)/img_hdr_logo.cfg

BOOT_LOGO_RESOURCE := $(TMP_DIR)/$(BOOT_LOGO).raw

RESOURCE_OBJ_LIST := \
    $(BOOT_LOGO)_uboot.raw \
    $(BOOT_LOGO)_kernel.raw \
    $(BOOT_LOGO)_battery.raw \
    $(BOOT_LOGO)_low_battery.raw \
    $(BOOT_LOGO)_charger_ov.raw \
    $(BOOT_LOGO)_num_0.raw \
    $(BOOT_LOGO)_num_1.raw \
    $(BOOT_LOGO)_num_2.raw \
    $(BOOT_LOGO)_num_3.raw \
    $(BOOT_LOGO)_num_4.raw \
    $(BOOT_LOGO)_num_5.raw \
    $(BOOT_LOGO)_num_6.raw \
    $(BOOT_LOGO)_num_7.raw \
    $(BOOT_LOGO)_num_8.raw \
    $(BOOT_LOGO)_num_9.raw \
    $(BOOT_LOGO)_num_percent.raw \
    $(BOOT_LOGO)_bat_animation_01.raw \
    $(BOOT_LOGO)_bat_animation_02.raw \
    $(BOOT_LOGO)_bat_animation_03.raw \
    $(BOOT_LOGO)_bat_animation_04.raw \
    $(BOOT_LOGO)_bat_animation_05.raw \
    $(BOOT_LOGO)_bat_animation_06.raw \
    $(BOOT_LOGO)_bat_animation_07.raw \
    $(BOOT_LOGO)_bat_animation_08.raw \
    $(BOOT_LOGO)_bat_animation_09.raw \
    $(BOOT_LOGO)_bat_animation_10.raw \
    $(BOOT_LOGO)_bat_10_01.raw \
    $(BOOT_LOGO)_bat_10_02.raw \
    $(BOOT_LOGO)_bat_10_03.raw \
    $(BOOT_LOGO)_bat_10_04.raw \
    $(BOOT_LOGO)_bat_10_05.raw \
    $(BOOT_LOGO)_bat_10_06.raw \
    $(BOOT_LOGO)_bat_10_07.raw \
    $(BOOT_LOGO)_bat_10_08.raw \
    $(BOOT_LOGO)_bat_10_09.raw \
    $(BOOT_LOGO)_bat_10_10.raw \
    $(BOOT_LOGO)_bat_bg.raw \
    $(BOOT_LOGO)_bat_img.raw \
    $(BOOT_LOGO)_bat_100.raw

all: $(LOGO_IMAGE)
	rm -rf $(TMP_DIR)/*

$(LOGO_IMAGE): $(MKIMAGE) $(BOOT_LOGO_RESOURCE) $(IMG_HDR_CFG)
	$(MKIMAGE) $(BOOT_LOGO_RESOURCE) $(IMG_HDR_CFG) > $(LOGO_IMAGE)

$(BOOT_LOGO_RESOURCE): $(ZPIPE) $(addprefix $(TMP_DIR)/,$(RESOURCE_OBJ_LIST))
	@$(MKDIR)
	$(ZPIPE) -l 9 $@ $(addprefix $(TMP_DIR)/,$(RESOURCE_OBJ_LIST))

$(TMP_DIR)/%.raw: $(RES_DIR)/$(BOOT_LOGO)/%.bmp $(BMP_TO_RAW)
	@$(MKDIR)
	$(BMP_TO_RAW) $@ $<
