# Transformation Automatique de YML to Objet : normalement c'est un Bug
# par défaut lorsque je fait yml.load il charge le code YML et non L'objet 

YAML::Syck::Resolver.class_eval do
  def transfer_with_autoload(type, val)
    match = type.match(/object:(\w+(?:::\w+)*)/)
    match && match[1].constantize
    transfer_without_autoload(type, val)
  end
  alias_method_chain :transfer, :autoload
end
