using System;

namespace BGLTF;

public static class CGLTF
{
	public static Result<Data*, CGLTFResult> ParseFile(ref Options options, StringView path)
	{
		Data* data = null;
		let result = cgltf_parse_file(&options, path.Ptr, &data);
		if (result case .Success)
		{
			return .Ok(data);
		}
		return .Err(result);
	}

	public static Result<Data*, CGLTFResult> Parse(ref Options options, Span<uint8> data)
	{
		Data* dd = null;
		let result = cgltf_parse(&options, data.Ptr, (uint)data.Length, &dd);
		if (result case .Success)
		{
			return .Ok(dd);
		}
		return .Err(result);
	}

	public static Result<void, CGLTFResult> LoadBuffers(ref Options options, Data* data, StringView path)
	{
		let result = cgltf_load_buffers(&options, data, path.Ptr);
		if (result != .Success)
			return .Err(result);
		return .Ok;
	}

	public static Result<void, CGLTFResult> Validate(Data* data)
	{
		let result = cgltf_validate(data);
		if (result != .Success)
			return .Err(result);
		return .Ok;
	}

	public static int32 DecodeString(StringView string)
	{
		return (int32)cgltf_decode_string(string.Ptr);
	}

	public static int32 DecodeUri(StringView uri)
	{
		return (int32)cgltf_decode_uri(uri.Ptr);
	}

	public static SizeT NumComponents(BGLTF.Type type)
	{
		return cgltf_num_components(type);
	}

	public static SizeT ComponentSize(ComponentType type)
	{
		return cgltf_component_size(type);
	}

	public static SizeT CalcSize(BGLTF.Type type, ComponentType componentType)
	{
		return cgltf_calc_size(type, componentType);
	}

	[CLink] internal static extern CGLTFResult cgltf_parse(Options* options, void* data, SizeT size, Data** out_data);
	[CLink] internal static extern CGLTFResult cgltf_parse_file(Options* options, char8* path, Data** out_data);
	[CLink] internal static extern CGLTFResult cgltf_load_buffers(Options* options, Data* data, char8* gltf_path);
	[CLink] internal static extern CGLTFResult cgltf_load_buffer_base64(Options* options, SizeT size, char8* base64, void** out_data);

	[CLink] internal static extern System.Interop.c_size cgltf_decode_string(char8* string);
	[CLink] internal static extern System.Interop.c_size cgltf_decode_uri(char8* uri);

	[CLink] internal static extern CGLTFResult cgltf_validate([MangleConst]Data* data);
	[CLink] internal static extern void cgltf_free(Data* data);

	[CLink] internal static extern void cgltf_node_transform_local(Node* node, float* out_matrix);
	[CLink] internal static extern void cgltf_node_transform_world(Node* node, float* out_matrix);

	[CLink] internal static extern uint8* cgltf_buffer_view_data(BufferView* view);

	[CLink] internal static extern Accessor* cgltf_find_accessor(Primitive* prim, AttributeType type, int32 index);

	[CLink] internal static extern Bool  cgltf_accessor_read_float(Accessor* accessor, SizeT index, float* out_ptr, SizeT element_size);
	[CLink] internal static extern Bool  cgltf_accessor_read_uint(Accessor* accessor, SizeT index, uint32* out_ptr, SizeT element_size);
	[CLink] internal static extern SizeT cgltf_accessor_read_index(Accessor* accessor, SizeT index);

	[CLink] internal static extern SizeT cgltf_num_components(BGLTF.Type type);
	[CLink] internal static extern SizeT cgltf_component_size(ComponentType component_type);
	[CLink] internal static extern SizeT cgltf_calc_size(BGLTF.Type type, ComponentType component_type);

	// @Todo: Understand and provide wrapper.
	[CLink] internal static extern SizeT cgltf_accessor_unpack_floats(Accessor* accessor, float* out_ptr, SizeT float_count);
	// @Todo: Understand and provide wrapper.
	[CLink] internal static extern SizeT cgltf_accessor_unpack_indices(Accessor* accessor, void* out_ptr, SizeT out_component_size, SizeT index_count);

	[CLink, Obsolete("this function is deprecated and will be removed in the future; use cgltf_extras::data instead")]
	internal static extern CGLTFResult cgltf_copy_extras_json(Data* data, Extras* extras, char8* dest, SizeT* dest_size);

	[CLink] internal static extern SizeT cgltf_mesh_index(Data* data, Mesh* object);
	[CLink] internal static extern SizeT cgltf_material_index(Data* data, Material* object);
	[CLink] internal static extern SizeT cgltf_accessor_index(Data* data, Accessor* object);
	[CLink] internal static extern SizeT cgltf_buffer_view_index(Data* data, BufferView* object);
	[CLink] internal static extern SizeT cgltf_buffer_index(Data* data, Buffer* object);
	[CLink] internal static extern SizeT cgltf_image_index(Data* data, Image* object);
	[CLink] internal static extern SizeT cgltf_texture_index(Data* data, Texture* object);
	[CLink] internal static extern SizeT cgltf_sampler_index(Data* data, Sampler* object);
	[CLink] internal static extern SizeT cgltf_camera_index(Data* data, Camera* object);
	[CLink] internal static extern SizeT cgltf_light_index(Data* data, Light* object);
	[CLink] internal static extern SizeT cgltf_node_index(Data* data, Node* object);
	[CLink] internal static extern SizeT cgltf_scene_index(Data* data, Scene* object);
	[CLink] internal static extern SizeT cgltf_animation_index(Data* data, Animation* object);
	[CLink] internal static extern SizeT cgltf_animation_sampler_index(Animation* animation, AnimationSampler* object);
	[CLink] internal static extern SizeT cgltf_channel_index(Animation* animation, AnimationChannel* object);
}
