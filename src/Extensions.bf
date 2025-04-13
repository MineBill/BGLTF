#pragma warning disable 4204
using System;
using System.Diagnostics;
using internal BGLTF;
using static BGLTF.CGLTF;

namespace BGLTF;

extension Data
{
	[CallingConvention(.Cdecl)]
	public CGLTFResult Validate()
	{
		return cgltf_validate(&this);
	}

	[CallingConvention(.Cdecl)]
	public void Free()
	{
		cgltf_free(&this);
	}

	[CallingConvention(.Cdecl)]
	public SizeT MeshIndex(Mesh* mesh)
	{
		return cgltf_mesh_index(&this, mesh);
	}

	[CallingConvention(.Cdecl)]
	public SizeT AccessorIndex(Accessor* object)
	{
		return cgltf_accessor_index(&this, object);
	}

	[CallingConvention(.Cdecl)]
	public SizeT BufferIndex(Buffer* object)
	{
		return cgltf_buffer_index(&this, object);
	}

	[CallingConvention(.Cdecl)]
	public SizeT BufferViewIndex(BufferView* object)
	{
		return cgltf_buffer_view_index(&this, object);
	}

	[CallingConvention(.Cdecl)]
	public SizeT ImageIndex(Image* object)
	{
		return cgltf_image_index(&this, object);
	}

	[CallingConvention(.Cdecl)]
	public SizeT TextureIndex(Texture* object)
	{
		return cgltf_texture_index(&this, object);
	}

	[CallingConvention(.Cdecl)]
	public SizeT SamplerIndex(Sampler* object)
	{
		return cgltf_sampler_index(&this, object);
	}

	[CallingConvention(.Cdecl)]
	public SizeT CameraIndex(Camera* object)
	{
		return cgltf_camera_index(&this, object);
	}

	[CallingConvention(.Cdecl)]
	public SizeT LightIndex(Light* object)
	{
		return cgltf_light_index(&this, object);
	}

	[CallingConvention(.Cdecl)]
	public SizeT NodeIndex(Node* object)
	{
		return cgltf_node_index(&this, object);
	}

	[CallingConvention(.Cdecl)]
	public SizeT SceneIndex(Scene* object)
	{
		return cgltf_scene_index(&this, object);
	}

	[CallingConvention(.Cdecl)]
	public SizeT AnimationIndex(Animation* object)
	{
		return cgltf_animation_index(&this, object);
	}
}

extension Animation
{
	[CallingConvention(.Cdecl)]
	public SizeT AnimationSamplerIndex(AnimationSampler* object)
	{
		return cgltf_animation_sampler_index(&this, object);
	}

	[CallingConvention(.Cdecl)]
	public SizeT ChannelIndex(AnimationChannel* object)
	{
		return cgltf_channel_index(&this, object);
	}
}

extension Node
{
	[CallingConvention(.Cdecl)]
	public void TransformLocal(Span<float> matrix)
	{
		Debug.Assert(matrix.Length >= 16, "Matrix requires at least 16 elements");
		cgltf_node_transform_local(&this, matrix.Ptr);
	}

	[CallingConvention(.Cdecl)]
	public void TransformWorld(Span<float> matrix)
	{
		Debug.Assert(matrix.Length >= 16, "Matrix requires at least 16 elements");
		cgltf_node_transform_world(&this, matrix.Ptr);
	}
}

extension BufferView
{
	[CallingConvention(.Cdecl)]
	public uint8* Data()
	{
		return cgltf_buffer_view_data(&this);
	}
}

extension Primitive
{
	[CallingConvention(.Cdecl)]
	public Accessor* FindAccessor(AttributeType type, int32 index)
	{
		return cgltf_find_accessor(&this, type, index);
	}
}

extension Accessor
{
	[CallingConvention(.Cdecl)]
	public bool ReadFloat(SizeT index, float* outPtr, SizeT elementSize)
	{
		return cgltf_accessor_read_float(&this, index, outPtr, elementSize) == 1;
	}

	[CallingConvention(.Cdecl)]
	public bool ReadUInt(SizeT index, uint32* outPtr, SizeT elementSize)
	{
		return cgltf_accessor_read_uint(&this, index, outPtr, elementSize) == 1;
	}

	[CallingConvention(.Cdecl)]
	public SizeT ReadIndex(SizeT index)
	{
		return cgltf_accessor_read_index(&this, index);
	}
}