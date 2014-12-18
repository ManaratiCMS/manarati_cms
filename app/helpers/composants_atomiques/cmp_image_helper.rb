module ComposantsAtomiques::CmpImageHelper
  def cmp_img_by_reference(reference_image,arg={})
   # image = MultimediaDataManager.load_image(reference_image)
   #arg.merge({:alt=>image.text_alt})
    image_tag("/media/images_sys/#{reference_image}", arg)
  end
end
