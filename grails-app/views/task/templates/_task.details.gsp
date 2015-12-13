%{--
- Copyright (c) 2015 Kagilum.
-
- This file is part of iceScrum.
-
- iceScrum is free software: you can redistribute it and/or modify
- it under the terms of the GNU Affero General Public License as published by
- the Free Software Foundation, either version 3 of the License.
-
- iceScrum is distributed in the hope that it will be useful,
- but WITHOUT ANY WARRANTY; without even the implied warranty of
- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- GNU General Public License for more details.
-
- You should have received a copy of the GNU Affero General Public License
- along with iceScrum.  If not, see <http://www.gnu.org/licenses/>.
-
- Authors:
-
- Vincent Barrier (vbarrier@kagilum.com)
- Nicolas Noullet (nnoullet@kagilum.com)
--}%
<script type="text/ng-template" id="task.details.html">
<div class="panel panel-light"
     flow-init
     flow-drop
     flow-files-submitted="attachmentQuery($flow, task)"
     flow-drop-enabled="authorizedTask('upload', task)"
     flow-drag-enter="dropClass='panel panel-light drop-enabled'"
     flow-drag-leave="dropClass='panel panel-light'"
     ng-class="authorizedTask('upload', task) && dropClass">
    <div class="panel-heading">
        <h3 class="panel-title row">
            <div class="left-title">
                <span>{{ task.name }}</span>
            </div>
            <div class="right-title">
                <span uib-tooltip="${message(code: 'is.task.creator')} {{ task.creator | userFullName }}">
                    <img ng-src="{{ task.creator | userAvatar }}" alt="{{ task.creator | userFullName }}"
                         height="30px"/>
                </span>
                <span ng-if="task.responsible"
                      uib-tooltip="${message(code: 'is.task.responsible')} {{ task.responsible | userFullName }}">
                    <img ng-src="{{ task.responsible | userAvatar }}" alt="{{ task.responsible | userFullName }}"
                         height="30px"/>
                </span>
                <button class="btn btn-default elemid">{{ task.uid }}</button>
                <div class="btn-group"
                     uib-dropdown
                     uib-tooltip="${message(code: 'todo.is.ui.actions')}">
                    <button type="button" class="btn btn-default" uib-dropdown-toggle>
                        <span class="fa fa-cog"></span> <span class="caret"></span>
                    </button>
                    <ul class="uib-dropdown-menu pull-right" ng-include="'task.menu.html'"></ul>
                </div>
                <a ng-if="previousTask"
                   class="btn btn-default"
                   role="button"
                   tabindex="0"
                   href="#{{ ::viewName }}/{{ ::previousTask.id }}"><i class="fa fa-caret-left" title="${message(code:'is.ui.backlogelement.toolbar.previous')}"></i></a>
                <a ng-if="nextTask"
                   class="btn btn-default"
                   role="button"
                   tabindex="0"
                   href="#{{ ::viewName }}/{{ ::nextTask.id }}"><i class="fa fa-caret-right" title="${message(code:'is.ui.backlogelement.toolbar.next')}"></i></a>
                <a class="btn btn-default"
                   href="#{{ ::viewName }}"
                   uib-tooltip="${message(code: 'is.ui.window.closeable')}">
                    <i class="fa fa-times"></i>
                </a>
            </div>
        </h3>
    </div>
    <div ui-view="details-tab">
        <form ng-submit="update(editableTask)"
              name='formHolder.taskForm'
              ng-class="{'form-editable':formHolder.editable, 'form-editing': formHolder.editing }"
              show-validation
              novalidate>
            <div class="panel-body">
                <div class="form-group">
                    <label for="name">${message(code:'is.task.name')}</label>
                    <div class="input-group">
                        <input required
                               ng-maxlength="100"
                               ng-focus="editForm(true)"
                               ng-disabled="!formHolder.editable"
                               name="name"
                               ng-model="editableTask.name"
                               type="text"
                               class="form-control">
                        <span class="input-group-btn" ng-if="formHolder.editable">
                            <button colorpicker
                                    class="btn {{ editableTask.color | contrastColor }}"
                                    type="button"
                                    style="background-color:{{ editableTask.color }};"
                                    colorpicker-position="left"
                                    ng-focus="editForm(true)"
                                    value="#bf3d3d"
                                    name="color"
                                    ng-model="editableTask.color"><i class="fa fa-pencil"></i></button>
                        </span>
                    </div>
                </div>
                <div class="form-group">
                    <label for="estimation">${message(code:'is.task.estimation')}</label>
                    <input type="number"
                           class="form-control"
                           ng-focus="editForm(true)"
                           ng-disabled="!formHolder.editable"
                           name="estimation"
                           ng-model="editableTask.estimation"/>
                </div>
                <div class="form-group">
                    <label for="description">${message(code:'is.backlogelement.description')}</label>
                    <textarea class="form-control important"
                              ng-maxlength="3000"
                              ng-focus="editForm(true)"
                              ng-disabled="!formHolder.editable"
                              placeholder="${message(code:'is.ui.backlogelement.nodescription')}"
                              name="description"
                              ng-model="editableTask.description"></textarea>
                </div>
                <div class="form-group">
                    <label for="tags">${message(code:'is.backlogelement.tags')}</label>
                    <ui-select class="form-control"
                               ng-click="retrieveTags(); editForm(true)"
                               ng-disabled="!formHolder.editable"
                               multiple
                               tagging
                               tagging-tokens="SPACE|,"
                               tagging-label=""
                               ng-model="editableTask.tags">
                        <ui-select-match placeholder="${message(code:'is.ui.backlogelement.notags')}">{{ $item }}</ui-select-match>
                        <ui-select-choices repeat="tag in tags">{{ tag }}</ui-select-choices>
                    </ui-select>
                </div>
                <div class="form-group">
                    <label for="notes">${message(code:'is.backlogelement.notes')}</label>
                    <textarea is-markitup
                              class="form-control"
                              ng-maxlength="5000"
                              name="notes"
                              ng-model="editableTask.notes"
                              is-model-html="editableTask.notes_html"
                              ng-show="showNotesTextarea"
                              ng-blur="showNotesTextarea = false"
                              placeholder="${message(code: 'is.ui.backlogelement.nonotes')}"></textarea>
                    <div class="markitup-preview important"
                         ng-disabled="!formHolder.editable"
                         ng-show="!showNotesTextarea"
                         ng-click="showNotesTextarea = formHolder.editable"
                         ng-focus="editForm(true); showNotesTextarea = formHolder.editable"
                         ng-class="{'placeholder': !editableTask.notes_html}"
                         tabindex="0"
                         ng-bind-html="(editableTask.notes_html ? editableTask.notes_html : '<p>${message(code: 'is.ui.backlogelement.nonotes')}</p>') | sanitize"></div>
                </div>
                <div class="form-group">
                    <label>${message(code:'is.backlogelement.attachment')} {{ task.attachments.length > 0 ? '(' + task.attachments.length + ')' : '' }}</label>
                    <div ng-if="authorizedTask('upload', task)">
                        <button type="button" class="btn btn-default" flow-btn><i
                                class="fa fa-upload"></i> ${message(code: 'todo.is.ui.new.upload')}</button>
                    </div>
                    <div class="form-control-static" ng-include="'attachment.list.html'">
                    </div>
                </div>
            </div>
            <div class="panel-footer" ng-if="formHolder.editing">
                <div class="btn-toolbar">
                    <button class="btn btn-primary"
                            ng-disabled="!isDirty() || formHolder.taskForm.$invalid"
                            uib-tooltip="${message(code:'default.button.update.label')} (RETURN)"
                            type="submit">
                        ${message(code:'default.button.update.label')}
                    </button>
                    <button class="btn confirmation btn-default"
                            uib-tooltip="${message(code:'is.button.cancel')}"
                            type="button"
                            ng-click="editForm(false)">
                        ${message(code:'is.button.cancel')}
                    </button>
                </div>
            </div>
        </form>
    </div>
</div>
</script>