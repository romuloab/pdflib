local ffi = require 'ffi'
local lib = ffi.load( 'pdflibffi' )

ffi.cdef[[
typedef enum
{
    pcos_mode_minimum	 = 0,
    pcos_mode_restricted = 1,
    pcos_mode_full	 = 2
} pcos_mode;

typedef enum
{
    pcos_ot_null	= 0,
    pcos_ot_boolean	= 1,
    pcos_ot_number	= 2,
    pcos_ot_name	= 3,
    pcos_ot_string	= 4,
    pcos_ot_array	= 5,
    pcos_ot_dict	= 6,
    pcos_ot_stream	= 7,
    pcos_ot_fstream	= 8
} pcos_object_type;

typedef void PDF;
typedef struct PDFlib_api_s PDFlib_api;
typedef size_t (*writeproc_t)(PDF *p1, void *data, size_t size);

typedef void  (*errorproc_t)(PDF *p1, int errortype, const char *msg);
typedef void* (*allocproc_t)(PDF *p2, size_t size, const char *caller);
typedef void* (*reallocproc_t)(PDF *p3, void *mem, size_t size, const char *caller);
typedef void  (*freeproc_t)(PDF *p4, void *mem);

void                  PDF_activate_item(const PDF *p, int id);
int                   PDF_add_bookmark(PDF *p, const char *text, int parent, int open);
int                   PDF_add_bookmark2(PDF *p, const char *text, int len, int parent, int open);
void                  PDF_add_launchlink(PDF *p, double llx, double lly, double urx, double ury, const char *filename);
void                  PDF_add_locallink(PDF *p, double llx, double lly, double urx, double ury, int page, const char *optlist);
void                  PDF_add_nameddest(PDF *p, const char *name, int len, const char *optlist);
void                  PDF_add_note(PDF *p, double llx, double lly, double urx, double ury, const char *contents, const char *title, const char *icon, int open);
void                  PDF_add_note2(PDF *p, double llx, double lly, double urx, double ury, const char *contents, int len_cont, const char *title, int len_title, const char *icon, int open);
int                   PDF_add_path_point(PDF *p, int path, double x, double y, const char *type, const char *optlist);
void                  PDF_add_pdflink(PDF *p, double llx, double lly, double urx, double ury, const char *filename, int page, const char *optlist);
int                   PDF_add_portfolio_file(PDF *p, int folder, const char *filename, int len, const char *optlist);
int                   PDF_add_portfolio_folder(PDF *p, int parent, const char *foldername, int len, const char *optlist);
int                   PDF_add_table_cell(PDF *p, int table, int column, int row, const char *text, int len, const char *optlist);
int                   PDF_add_textflow(PDF *p, int textflow, const char *text, int len, const char *optlist);
void                  PDF_add_thumbnail(PDF *p, int image);
void                  PDF_add_weblink(PDF *p, double llx, double lly, double urx, double ury, const char *url);
void                  PDF_align(PDF *p, double dx, double dy);
void                  PDF_arc(PDF *p, double x, double y, double r, double alpha, double beta);
void                  PDF_arcn(PDF *p, double x, double y, double r, double alpha, double beta);
void                  PDF_attach_file(PDF *p, double llx, double lly, double urx, double ury, const char *filename, const char *description, const char *author, const char *mimetype, const char *icon);
void                  PDF_attach_file2(PDF *p, double llx, double lly, double urx, double ury, const char *filename, int len_filename, const char *description, int len_descr, const char *author, int len_auth, const char *mimetype, const char *icon);
int                   PDF_begin_document(PDF *p, const char *filename, int len, const char *optlist);
void                  PDF_begin_document_callback(PDF *p, writeproc_t writeproc, const char *optlist);
void                  PDF_begin_dpart(PDF *p, const char *optlist);
void                  PDF_begin_font(PDF *p, const char *fontname, int len, double a, double b, double c, double d, double e, double f, const char *optlist);
void                  PDF_begin_glyph(PDF *p, const char *glyphname, double wx, double llx, double lly, double urx, double ury);
void                  PDF_begin_glyph_ext(PDF *p, int uv, const char *optlist);
int                   PDF_begin_item(PDF *p, const char *tagname, const char *optlist);
void                  PDF_begin_layer(PDF *p, int layer);
void                  PDF_begin_mc(PDF *p, const char *tagname, const char *optlist);
void                  PDF_begin_page(PDF *p, double width, double height);
void                  PDF_begin_page_ext(PDF *p, double width, double height, const char *optlist);
int                   PDF_begin_pattern(PDF *p, double width, double height, double xstep, double ystep, int painttype);
int                   PDF_begin_pattern_ext(PDF *p, double width, double height, const char *optlist);
int                   PDF_begin_template(PDF *p, double width, double height);
int                   PDF_begin_template_ext(PDF *p, double width, double height, const char *optlist);
void                  PDF_boot(void);
int                   PDF_check_context(PDF *p);
void                  PDF_circle(PDF *p, double x, double y, double r);
void                  PDF_circular_arc(PDF *p, double x1, double y1, double x2, double y2);
void                  PDF_clip(PDF *p);
void                  PDF_close(PDF *p);
void                  PDF_close_font(PDF *p, int font);
void                  PDF_close_graphics(PDF *p, int graphics);
void                  PDF_close_image(PDF *p, int image);
void                  PDF_close_pdi(PDF *p, int doc);
void                  PDF_close_pdi_document(PDF *p, int doc);
void                  PDF_close_pdi_page(PDF *p, int page);
void                  PDF_closepath(PDF *p);
void                  PDF_closepath_fill_stroke(PDF *p);
void                  PDF_closepath_stroke(PDF *p);
void                  PDF_concat(PDF *p, double a, double b, double c, double d, double e, double f);
void                  PDF_continue_text(PDF *p, const char *text);
void                  PDF_continue_text2(PDF *p, const char *text, int len);
const char *          PDF_convert_to_unicode(PDF *p, const char *inputformat, const char *inputstring, int inputlen, int *outputlen, const char *optlist);
int                   PDF_create_3dview(PDF *p, const char *username, int len, const char *optlist);
int                   PDF_create_action(PDF *p, const char *type, const char *optlist);
void                  PDF_create_annotation(PDF *p, double llx, double lly, double urx, double ury, const char *type, const char *optlist);
int                   PDF_create_bookmark(PDF *p, const char *text, int len, const char *optlist);
void                  PDF_create_field(PDF *p, double llx, double lly, double urx, double ury, const char *name, int len, const char *type, const char *optlist);
void                  PDF_create_fieldgroup(PDF *p, const char *name, int len, const char *optlist);
int                   PDF_create_gstate(PDF *p, const char *optlist);
void                  PDF_create_pvf(PDF *p, const char *filename, int len, const void *data, size_t size, const char *optlist);
int                   PDF_create_textflow(PDF *p, const char *text, int len, const char *optlist);
void                  PDF_curveto(PDF *p, double x1, double y1, double x2, double y2, double x3, double y3);
int                   PDF_define_layer(PDF *p, const char *name, int len, const char *optlist);
const char *          PDF_deflate_unicode(PDF *p, const char *utfstring, int len, int charsize, int *highchar);
void                  PDF_delete(PDF *p);
void                  PDF_delete_path(PDF *p, int path);
int                   PDF_delete_pvf(PDF *p, const char *filename, int len);
void                  PDF_delete_table(PDF *p, int table, const char *optlist);
void                  PDF_delete_textflow(PDF *p, int textflow);
void                  PDF_draw_path(PDF *p, int path, double x, double y, const char *optlist);
void                  PDF_ellipse(PDF *p, double x, double y, double rx, double ry);
void                  PDF_elliptical_arc(PDF *p, double x, double y, double rx, double ry, const char *optlist);
void                  PDF_encoding_set_char(PDF *p, const char *encoding, int slot, const char *glyphname, int uv);
void                  PDF_end_document(PDF *p, const char *optlist);
void                  PDF_end_dpart(PDF *p, const char *optlist);
void                  PDF_end_font(PDF *p);
void                  PDF_end_glyph(PDF *p);
void                  PDF_end_item(PDF *p, int id);
void                  PDF_end_layer(PDF *p);
void                  PDF_end_mc(PDF *p);
void                  PDF_end_page(PDF *p);
void                  PDF_end_page_ext(PDF *p, const char *optlist);
void                  PDF_end_pattern(PDF *p);
void                  PDF_end_template(PDF *p);
void                  PDF_end_template_ext(PDF *p, double width, double height);
void                  PDF_endpath(PDF *p);
void                  PDF_fill(PDF *p);
int                   PDF_fill_graphicsblock(PDF *p, int page, const char *blockname, int graphics, const char *optlist);
int                   PDF_fill_imageblock(PDF *p, int page, const char *blockname, int image, const char *optlist);
int                   PDF_fill_pdfblock(PDF *p, int page, const char *blockname, int contents, const char *optlist);
void                  PDF_fill_stroke(PDF *p);
int                   PDF_fill_textblock(PDF *p, int page, const char *blockname, const char *text, int len, const char *optlist);
int                   PDF_findfont(PDF *p, const char *fontname, const char *encoding, int embed);
void                  PDF_fit_graphics(PDF *p, int graphics, double x, double y, const char *optlist);
void                  PDF_fit_image(PDF *p, int image, double x, double y, const char *optlist);
void                  PDF_fit_pdi_page(PDF *p, int page, double x, double y, const char *optlist);
const char *          PDF_fit_table(PDF *p, int table, double llx, double lly, double urx, double ury, const char *optlist);
const char *          PDF_fit_textflow(PDF *p, int textflow, double llx, double lly, double urx, double ury, const char *optlist);
void                  PDF_fit_textline(PDF *p, const char *text, int len, double x, double y, const char *optlist);
const char *          PDF_get_apiname(PDF *p);
const char *          PDF_get_buffer(PDF *p, long *size);
const char *          PDF_get_errmsg(PDF *p);
int                   PDF_get_errnum(PDF *p);
double                PDF_get_kern_amount(PDF *p, int font, int gidleft, int gidright);
int                   PDF_get_majorversion(void);
int                   PDF_get_minorversion(void);
void *                PDF_get_opaque(PDF *p);
double                PDF_get_option(PDF *p, const char *keyword, const char *optlist);
const char *          PDF_get_parameter(PDF *p, const char *key, double modifier);
const char *          PDF_get_pdi_parameter(PDF *p, const char *key, int doc, int page, int reserved, int *len);
double                PDF_get_pdi_value(PDF *p, const char *key, int doc, int page, int reserved);
const char *          PDF_get_string(PDF *p, int idx, const char *optlist);
double                PDF_get_value(PDF *p, const char *key, double modifier);
double                PDF_info_font(PDF *p, int font, const char *keyword, const char *optlist);
double                PDF_info_graphics(PDF *p, int graphics, const char *keyword, const char *optlist);
double                PDF_info_image(PDF *p, int image, const char *keyword, const char *optlist);
double                PDF_info_matchbox(PDF *p, const char *boxname, int len, int num, const char *keyword);
double                PDF_info_path(PDF *p, int path, const char *keyword, const char *optlist);
double                PDF_info_pdi_page(PDF *p, int page, const char *keyword, const char *optlist);
double                PDF_info_pvf(PDF *p, const char *filename, int len, const char *keyword);
double                PDF_info_table(PDF *p, int table, const char *keyword);
double                PDF_info_textflow(PDF *p, int textflow, const char *keyword);
double                PDF_info_textline(PDF *p, const char *text, int len, const char *keyword, const char *optlist);
void                  PDF_initgraphics(PDF *p);
void                  PDF_lineto(PDF *p, double x, double y);
int                   PDF_load_3ddata(PDF *p, const char *filename, int len, const char *optlist);
int                   PDF_load_asset(PDF *p, const char *type, const char *filename, int len, const char *optlist);
int                   PDF_load_font(PDF *p, const char *fontname, int len, const char *encoding, const char *optlist);
int                   PDF_load_graphics(PDF *p, const char *type, const char *filename, int len, const char *optlist);
int                   PDF_load_iccprofile(PDF *p, const char *profilename, int len, const char *optlist);
int                   PDF_load_image(PDF *p, const char *imagetype, const char *filename, int len, const char *optlist);
int                   PDF_makespotcolor(PDF *p, const char *spotname, int reserved);
void                  PDF_mc_point(PDF *p, const char *tagname, const char *optlist);
void                  PDF_moveto(PDF *p, double x, double y);
PDF *                 PDF_new(void);
PDF *                 PDF_new2(errorproc_t errorhandler, allocproc_t allocproc, reallocproc_t reallocproc, freeproc_t freeproc, void *opaque);
int                   PDF_open_CCITT(PDF *p, const char *filename, int width, int height, int BitReverse, int K, int BlackIs1);
int                   PDF_open_file(PDF *p, const char *filename);
int                   PDF_open_image(PDF *p, const char *imagetype, const char *source, const char *data, long length, int width, int height, int components, int bpc, const char *params);
int                   PDF_open_image_file(PDF *p, const char *imagetype, const char *filename, const char *stringparam, int intparam);
void                  PDF_open_mem(PDF *p, writeproc_t writeproc);
int                   PDF_open_pdi(PDF *p, const char *filename, const char *optlist, int len);
int                   PDF_open_pdi_document(PDF *p, const char *filename, int len, const char *optlist);
int                   PDF_open_pdi_callback(PDF *p, void *opaque, size_t filesize, size_t (*readproc)(void *opaque, void *buffer, size_t size), int (*seekproc)(void *opaque, long offset), const char *optlist);
int                   PDF_open_pdi_page(PDF *p, int doc, int pagenumber, const char *optlist);
double                PDF_pcos_get_number(PDF *p, int doc, const char *path, ...);
const char *          PDF_pcos_get_string(PDF *p, int doc, const char *path, ...);
const unsigned char * PDF_pcos_get_stream(PDF *p, int doc, int *length, const char *optlist, const char *path, ...);
void                  PDF_place_image(PDF *p, int image, double x, double y, double scale);
void                  PDF_place_pdi_page(PDF *p, int page, double x, double y, double sx, double sy);
void                  PDF_poca_delete(PDF *p, int container, const char *optlist);
void                  PDF_poca_insert(PDF *p, int container, const char *optlist);
int                   PDF_poca_new(PDF *p, const char *optlist);
void                  PDF_poca_remove(PDF *p, int container, const char *optlist);
int                   PDF_process_pdi(PDF *p, int doc, int page, const char *optlist);
void                  PDF_rcurveto(PDF *p, double x1, double y1, double x2, double y2, double x3, double y3);
void                  PDF_rect(PDF *p, double x, double y, double width, double height);
void                  PDF_restore(PDF *p);
void                  PDF_resume_page(PDF *p, const char *optlist);
void                  PDF_rlineto(PDF *p, double x, double y);
void                  PDF_rmoveto(PDF *p, double x, double y);
void                  PDF_rotate(PDF *p, double phi);
void                  PDF_save(PDF *p);
void                  PDF_scale(PDF *p, double sx, double sy);
void                  PDF_set_border_color(PDF *p, double red, double green, double blue);
void                  PDF_set_border_dash(PDF *p, double b, double w);
void                  PDF_set_border_style(PDF *p, const char *style, double width);
void                  PDF_set_graphics_option(PDF *p, const char *optlist);
void                  PDF_set_gstate(PDF *p, int gstate);
void                  PDF_set_info(PDF *p, const char *key, const char *value);
void                  PDF_set_info2(PDF *p, const char *key, const char *value, int len);
void                  PDF_set_layer_dependency(PDF *p, const char *type, const char *optlist);
void                  PDF_set_option(PDF *p, const char *optlist);
void                  PDF_set_parameter(PDF *p, const char *key, const char *value);
void                  PDF_set_text_option(PDF *p, const char *optlist);
void                  PDF_set_text_pos(PDF *p, double x, double y);
int                   PDF_set_textflow_variable(PDF *p, const char *varname, int namelen, const char *text, int textlen, const char *optlist);
void                  PDF_set_value(PDF *p, const char *key, double value);
void                  PDF_setcolor(PDF *p, const char *fstype, const char *colorspace, double c1, double c2, double c3, double c4);
void                  PDF_setdash(PDF *p, double b, double w);
void                  PDF_setdashpattern(PDF *p, const char *optlist);
void                  PDF_setflat(PDF *p, double flatness);
void                  PDF_setfont(PDF *p, int font, double fontsize);
void                  PDF_setgray(PDF *p, double gray);
void                  PDF_setgray_fill(PDF *p, double gray);
void                  PDF_setgray_stroke(PDF *p, double gray);
void                  PDF_setlinecap(PDF *p, int linecap);
void                  PDF_setlinejoin(PDF *p, int linejoin);
void                  PDF_setlinewidth(PDF *p, double width);
void                  PDF_setmatrix(PDF *p, double a, double b, double c, double d, double e, double f);
void                  PDF_setmiterlimit(PDF *p, double miter);
void                  PDF_setpolydash(PDF *p, float *dasharray, int length);
void                  PDF_setrgbcolor(PDF *p, double red, double green, double blue);
void                  PDF_setrgbcolor_fill(PDF *p, double red, double green, double blue);
void                  PDF_setrgbcolor_stroke(PDF *p, double red, double green, double blue);
int                   PDF_shading(PDF *p, const char *shtype, double x0, double y0, double x1, double y1, double c1, double c2, double c3, double c4, const char *optlist);
int                   PDF_shading_pattern(PDF *p, int shading, const char *optlist);
void                  PDF_shfill(PDF *p, int shading);
void                  PDF_show(PDF *p, const char *text);
void                  PDF_show2(PDF *p, const char *text, int len);
int                   PDF_show_boxed(PDF *p, const char *text, double left, double top, double width, double height, const char *hmode, const char *feature);
int                   PDF_show_boxed2(PDF *p, const char *text, int len, double left, double top, double width, double height, const char *hmode, const char *feature);
void                  PDF_show_xy(PDF *p, const char *text, double x, double y);
void                  PDF_show_xy2(PDF *p, const char *text, int len, double x, double y);
void                  PDF_shutdown(void);
void                  PDF_skew(PDF *p, double alpha, double beta);
double                PDF_stringwidth(PDF *p, const char *text, int font, double fontsize);
double                PDF_stringwidth2(PDF *p, const char *text, int len, int font, double fontsize);
void                  PDF_stroke(PDF *p);
void                  PDF_suspend_page(PDF *p, const char *optlist);
void                  PDF_translate(PDF *p, double tx, double ty);
const char *          PDF_utf16_to_utf8(PDF *p, const char *utf16string, int len, int *size);
const char *          PDF_utf8_to_utf16(PDF *p, const char *utf8string, const char *ordering, int *size);
const char *          PDF_utf32_to_utf8(PDF *p, const char *utf32string, int len, int *size);
const char *          PDF_utf8_to_utf32(PDF *p, const char *utf8string, const char *ordering, int *size);
const char *          PDF_utf16_to_utf32(PDF *p, const char *utf16string, int len, const char *ordering, int *size);
const char *          PDF_utf32_to_utf16(PDF *p, const char *utf32string, int len, const char *ordering, int *size);
void                  PDF_xshow(PDF *p, const char *text, int len, const double *xadvancelist);

/* Unsupported */
/*
 * const PDFlib_api *    PDF_get_api(void);
*/
]]

local str_api = {
    convert_to_unicode = true,
    deflate_unicode = true,
    fit_table = true,
    fit_textflow = true,
    get_apiname = true,
    get_buffer = true,
    get_errmsg = true,
    get_parameter = true,
    get_pdi_parameter = true,
    get_string = true,
    pcos_get_string = true,
    utf16_to_utf8 = true,
    utf8_to_utf16 = true,
    utf32_to_utf8 = true,
    utf8_to_utf32 = true,
    utf16_to_utf32 = true,
    utf32_to_utf16 = true,
}

local mt = {}
mt.__index = setmetatable( {}, { __index = function( symbols, k )
    if not k:match '^PDF_' then
        local fn = lib[ 'PDF_' .. k ]
        if str_api[ k ] then
            symbols[ k ] = function( self, ... )
                return ffi.string( fn( self.handle, ... ) )
            end
        else
            symbols[ k ] = function( self, ... )
                return fn( self.handle, ... )
            end
        end
    end
    return symbols[ k ]
end } )

local function new()
    return setmetatable( { handle = lib.PDF_new() }, mt )
end

return { new = new }
