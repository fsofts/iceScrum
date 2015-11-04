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
<script type="text/ng-template" id="release.new.html">
<div class="panel panel-default">
    <div class="panel-heading">
        <h3 class="panel-title">${message(code: "is.ui.release.toolbar.new")} ${message(code: "is.release")}</h3>
        <div class="help-block">${message(code:'is.ui.release.help')}</div>
    </div>
    <div class="right-properties new panel-body">
        <form ng-submit="save(release, false)"
              name='formHolder.releaseForm'
              novalidate>
            <div class="form-group">
                <label for="name">${message(code:'is.release.name')}</label>
                <input required
                       name="name"
                       focus-me="true"
                       ng-model="release.name"
                       type="text"
                       class="form-control"
                       placeholder="${message(code: 'is.ui.release.noname')}"/>
            </div>
            <div class="clearfix no-padding">
                <div class="form-half">
                    <label for="release.startDate">${message(code:'is.release.startDate')}</label>
                    <div class="input-group">
                        <span class="input-group-btn">
                            <button type="button"
                                    class="btn btn-default"
                                    ng-click="openDatepicker($event, startDateOptions)">
                                <i class="fa fa-calendar"></i>
                            </button>
                        </span>
                        <input type="text"
                               class="form-control"
                               required
                               name="release.startDate"
                               ng-model="release.startDate"
                               uib-datepicker-popup
                               min-date="minStartDate"
                               max-date="maxStartDate"
                               is-open="startDateOptions.opened"/>
                    </div>
                </div>
                <div class="form-half">
                    <label for="release.endDate" class="text-right">${message(code:'is.release.endDate')}</label>
                    <div class="input-group">
                        <input type="text"
                               class="form-control text-right"
                               required
                               name="release.endDate"
                               ng-model="release.endDate"
                               uib-datepicker-popup
                               min-date="minEndDate"
                               is-open="endDateOptions.opened"/>
                        <span class="input-group-btn">
                            <button type="button"
                                    class="btn btn-default"
                                    ng-click="openDatepicker($event, endDateOptions)">
                                <i class="fa fa-calendar"></i>
                            </button>
                        </span>
                    </div>
                </div>
            </div>
            <div class="btn-toolbar pull-right">
                <button class="btn btn-primary pull-right"
                        ng-disabled="formHolder.releaseForm.$invalid"
                        uib-tooltip="${message(code:'default.button.create.label')} (RETURN)"
                        tooltip-append-to-body="true"
                        type="submit">
                    ${message(code:'default.button.create.label')}
                </button>
                <button class="btn btn-primary pull-right"
                        ng-disabled="formHolder.releaseForm.$invalid"
                        uib-tooltip="${message(code:'todo.is.ui.create.and.continue')} (SHIFT+RETURN)"
                        tooltip-append-to-body="true"
                        hotkey="{'shift+return': hotkeyClick }"
                        hotkey-allow-in="INPUT"
                        type='button'
                        ng-click="save(release, true)">
                    ${message(code:'todo.is.ui.create.and.continue')}
                </button>
            </div>
        </form>
    </div>
</div>
</script>
