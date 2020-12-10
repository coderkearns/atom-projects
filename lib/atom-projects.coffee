AtomProjectsView = require './atom-projects-view'
{CompositeDisposable} = require 'atom'

module.exports = AtomProjects =
  atomProjectsView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @atomProjectsView = new AtomProjectsView(state.atomProjectsViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @atomProjectsView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-projects:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @atomProjectsView.destroy()

  serialize: ->
    atomProjectsViewState: @atomProjectsView.serialize()

  toggle: ->
    console.log 'AtomProjects was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
