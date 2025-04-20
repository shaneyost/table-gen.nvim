local TableGen = {}
local ffi = require("ffi")
local cfg = require("table-gen.config")
local utl = require("table-gen.utils")

local function create_cdef(struct_mems, struct_type, struct_size)
    local cdef = string.format(
        [[
typedef union
{
    struct __attribute__((__packed__))
    {
%s
    };
    uint8_t raw[%d];
} %s;
]],
        struct_mems,
        struct_size,
        struct_type
    )
    return cdef
end

local function create_binary(self, filename)
    local file = assert(io.open(filename, "wb"))
    file:write(ffi.string(self.raw, self:size()))
    file:close()
end

local function create_hashfile(self, filename)
    utl._compute_hash_table("shasum -a 256", filename)
end

-- TODO 
-- Keep our metatable simple. I don't quite know how __tostring should look so
-- make it reflect a simple hexdump like output for now.
local _metatable = {
    __index = {
        create_binary = create_binary,
        create_hashfile = create_hashfile,
        size = function(self) return ffi.sizeof(self) end,
    },
    __tostring = function(self)
        local out, size, fmt = {}, self:size(), cfg._cfg.outfmt
        for i = 0, size - 1 do
            -- TODO  I think we get a wee bit more runtime efficiency throw raw
            -- indexing than if we were to use table.insert. Maybe check this
            -- later. Be a nice little blog write up to research later.
            out[#out + 1] = string.format(fmt, self.raw[i])
            out[#out + 1] = ((i + 1) % 8 == 0) and "\n" or " "
        end
        return table.concat(out)
    end,
}

function TableGen.create_struct(struct_data)
    -- TODO
    -- Reduce runtime overhead later but for now lets break out the logic and
    -- make sure it works. I don't know how this will unfold yet so lets keep
    -- it simple for now. Perhaps later the design will naturally come to me.
    local struct_size = utl._extract_validate_struct_size(struct_data)
    local struct_type = utl._extract_validate_struct_type(struct_data)
    local struct_vals = utl._extract_validate_struct_init(struct_data)
    local struct_mems = utl._extract_validate_struct_mems(struct_data)
    -- INFO
    -- Register cdef w/ ffi registry and create type constructor
    local struct_cdef = create_cdef(struct_mems, struct_type, struct_size)
    -- TODO 
    -- Debug only
    print(string.format("\nStruct Def:\n%s", struct_cdef))
    ffi.cdef(struct_cdef)
    return ffi.metatype(ffi.typeof(struct_type), _metatable), struct_vals
end

return TableGen
