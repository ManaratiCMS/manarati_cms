module ComposantsAtomiques::CmpCommentaireFaceBookHelper
  def cmp_commentaire_face_book(obj)
    obj.texte = request.url
    render :partial => "composants_atomiques/cmp_commentaire_face_book/cmp_commentaire_face_book", :locals => { :obj => obj }
  end

  def cmp_commentaire_face_book_form(obj)
      render :partial=>"/composants_atomiques/cmp_commentaire_face_book/cmp_commentaire_face_book_form",:locals=>{:obj=>obj}
  end
end
